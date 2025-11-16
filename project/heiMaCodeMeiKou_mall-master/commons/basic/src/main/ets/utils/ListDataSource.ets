export class ListDataSource<T> implements IDataSource {

  private  originArr: T[] = []
  private listeners: DataChangeListener[] = [];

  totalCount(): number {
    return this.originArr.length
  }

  getData(index: number): T {
    return this.originArr[index];
  }

  loadData(data: T[]) {
    this.originArr = data
    this.listeners.forEach((listener)=>{
      listener.onDataReloaded()
    })
  }

  pushData(data: T[]){
    this.originArr.push(...data)
    this.listeners.forEach((listener)=>{
      listener.onDataReloaded()
    })
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener');
      this.listeners.push(listener);
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }

}