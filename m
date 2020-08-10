Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56442240887
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Aug 2020 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHJPUa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Aug 2020 11:20:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:40058 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgHJPU3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 10 Aug 2020 11:20:29 -0400
IronPort-SDR: c57bP48khJGnEBwgvX6gCZDDzA1zSzkmwpLrEYleXLmQHrHQAEZ/aLpbi293LWSoWfRMfSDbtc
 iwT4c1zlbeQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="152764957"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="152764957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 08:20:29 -0700
IronPort-SDR: NCgUPc83FC+CLsqT7ypkvd9z5vd3DbvOvTNTThs4UhbJkzkVPlE1Cv3bbs3dWbg31n4/hgRE0y
 oQhhFzlbR/iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="494828259"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 10 Aug 2020 08:20:26 -0700
Date:   Mon, 10 Aug 2020 23:16:51 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH v4 3/4] fpga: dfl: create a dfl bus type to support DFL
  devices
Message-ID: <20200810151651.GB5813@yilunxu-OptiPlex-7050>
References: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
 <1597027273-25288-4-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819E2036BA04CC8B89FDB0C85440@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819E2036BA04CC8B89FDB0C85440@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 10, 2020 at 02:36:44PM +0800, Wu, Hao wrote:
> >
> > A new bus type "dfl" is introduced for private features which are not
> > initialized by DFL feature drivers (dfl-fme & dfl-afu drivers). So these
> > private features could be handled by separate driver modules.
> >
> > DFL feature drivers (dfl-fme, dfl-port) will create DFL devices on
> > enumeration. DFL drivers could be registered on this bus to match these
> > DFL devices. They are matched by dfl type & feature_id.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > ---
> > v2: change the bus uevent format.
> >     change the dfl device's sysfs name format.
> >     refactor dfl_dev_add().
> >     minor fixes for comments from Hao and Tom.
> > v3: no change.
> > v4: improve the uevent format, 4 bits for type & 12 bits for id.
> >     change dfl_device->type to u8.
> >     A dedicate field in struct dfl_feature for dfl device instance.
> >     error out if dfl_device already exist on dfl_devs_init().
> > ---
> >  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
> >  drivers/fpga/dfl.c                      | 263 +++++++++++++++++++++++++++++++-
> >  drivers/fpga/dfl.h                      |  85 +++++++++++
> >  3 files changed, 355 insertions(+), 8 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl
> > b/Documentation/ABI/testing/sysfs-bus-dfl
> > new file mode 100644
> > index 0000000..4d74cc0
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-dfl
> > @@ -0,0 +1,15 @@
> > +What:/sys/bus/dfl/devices/dfl_dev.X/type
> > +Date:July 2020
> > +KernelVersion:5.10
> > +Contact:Xu Yilun <yilun.xu@intel.com>
> > +Description:Read-only. It returns type of DFL FIU of the device. Now DFL
> > +supports 2 FIU types, 0 for FME, 1 for PORT.
> > +Format: 0x%x
> > +
> > +What:/sys/bus/dfl/devices/dfl_dev.X/feature_id
> > +Date:July 2020
> > +KernelVersion:5.10
> > +Contact:Xu Yilun <yilun.xu@intel.com>
> > +Description:Read-only. It returns feature identifier local to its DFL FIU
> > +type.
> > +Format: 0x%x
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index b5257d7..51cef85 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -30,12 +30,6 @@ static DEFINE_MUTEX(dfl_id_mutex);
> >   * index to dfl_chardevs table. If no chardev support just set devt_type
> >   * as one invalid index (DFL_FPGA_DEVT_MAX).
> >   */
> > -enum dfl_id_type {
> > -FME_ID,/* fme id allocation and mapping */
> > -PORT_ID,/* port id allocation and mapping */
> > -DFL_ID_MAX,
> > -};
> > -
> >  enum dfl_fpga_devt_type {
> >  DFL_FPGA_DEVT_FME,
> >  DFL_FPGA_DEVT_PORT,
> > @@ -250,6 +244,245 @@ int dfl_fpga_check_port_id(struct platform_device
> > *pdev, void *pport_id)
> >  }
> >  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
> >
> > +static DEFINE_IDA(dfl_device_ida);
> > +
> > +static const struct dfl_device_id *
> > +dfl_match_one_device(const struct dfl_device_id *id, struct dfl_device
> > *ddev)
> > +{
> > +if (id->type == ddev->type && id->feature_id == ddev->feature_id)
> > +return id;
> > +
> > +return NULL;
> > +}
> > +
> > +static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> > +{
> > +struct dfl_device *ddev = to_dfl_dev(dev);
> > +struct dfl_driver *ddrv = to_dfl_drv(drv);
> > +const struct dfl_device_id *id_entry = ddrv->id_table;
> > +
> > +if (id_entry) {
> > +while (id_entry->feature_id) {
> > +if (dfl_match_one_device(id_entry, ddev)) {
> > +ddev->id_entry = id_entry;
> > +return 1;
> > +}
> > +id_entry++;
> > +}
> > +}
> > +
> > +return 0;
> > +}
> > +
> > +static int dfl_bus_probe(struct device *dev)
> > +{
> > +struct dfl_device *ddev = to_dfl_dev(dev);
> > +struct dfl_driver *ddrv = to_dfl_drv(dev->driver);
> > +
> > +return ddrv->probe(ddev);
> > +}
> > +
> > +static int dfl_bus_remove(struct device *dev)
> > +{
> > +struct dfl_device *ddev = to_dfl_dev(dev);
> > +struct dfl_driver *ddrv = to_dfl_drv(dev->driver);
> > +
> > +if (ddrv->remove)
> > +ddrv->remove(ddev);
> > +
> > +return 0;
> > +}
> > +
> > +static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> > +{
> > +struct dfl_device *ddev = to_dfl_dev(dev);
> > +
> > +/* The type has 4 valid bits and feature_id has 12 valid bits */
> > +return add_uevent_var(env, "MODALIAS=dfl:t%01Xf%03X",
> > +      ddev->type, ddev->feature_id);
> > +}
> > +
> > +/* show dfl info fields */
> > +#define dfl_info_attr(field, format_string)\
> > +static ssize_t\
> > +field##_show(struct device *dev, struct device_attribute *attr,
> > \
> > +     char *buf)\
> > +{\
> > +struct dfl_device *ddev = to_dfl_dev(dev);\
> > +\
> > +return sprintf(buf, format_string, ddev->field);\
> > +}\
> > +static DEVICE_ATTR_RO(field)
> > +
> > +dfl_info_attr(type, "0x%x\n");
> > +dfl_info_attr(feature_id, "0x%x\n");
> > +
> > +static struct attribute *dfl_dev_attrs[] = {
> > +&dev_attr_type.attr,
> > +&dev_attr_feature_id.attr,
> > +NULL,
> > +};
> > +
> > +ATTRIBUTE_GROUPS(dfl_dev);
> > +
> > +static struct bus_type dfl_bus_type = {
> > +.name= "dfl",
> > +.match= dfl_bus_match,
> > +.probe= dfl_bus_probe,
> > +.remove= dfl_bus_remove,
> > +.uevent= dfl_bus_uevent,
> > +.dev_groups= dfl_dev_groups,
> > +};
> > +
> > +static void release_dfl_dev(struct device *dev)
> > +{
> > +struct dfl_device *ddev = to_dfl_dev(dev);
> > +
> > +if (ddev->mmio_res.parent)
> > +release_resource(&ddev->mmio_res);
> > +
> > +ida_simple_remove(&dfl_device_ida, ddev->id);
> > +kfree(ddev->irqs);
> > +kfree(ddev);
> > +}
> > +
> > +static struct dfl_device *
> > +dfl_dev_add(struct dfl_feature_platform_data *pdata,
> > +    struct dfl_feature *feature)
> > +{
> > +struct platform_device *pdev = pdata->dev;
> > +struct resource *parent_res;
> > +struct dfl_device *ddev;
> > +int id, i, ret;
> > +
> > +ddev = kzalloc(sizeof(*ddev), GFP_KERNEL);
> > +if (!ddev)
> > +return ERR_PTR(-ENOMEM);
> > +
> > +id = ida_simple_get(&dfl_device_ida, 0, 0, GFP_KERNEL);
> > +if (id < 0) {
> > +dev_err(&pdev->dev, "unable to get id\n");
> > +kfree(ddev);
> > +return ERR_PTR(id);
> > +}
> > +
> > +/* freeing resources by put_device() after device_initialize() */
> > +device_initialize(&ddev->dev);
> > +ddev->dev.parent = &pdev->dev;
> > +ddev->dev.bus = &dfl_bus_type;
> > +ddev->dev.release = release_dfl_dev;
> > +ddev->id = id;
> > +ret = dev_set_name(&ddev->dev, "dfl_dev.%d", id);
> > +if (ret)
> > +goto put_dev;
> > +
> > +ddev->type = feature_dev_id_type(pdev);
> > +ddev->feature_id = feature->id;
> > +ddev->cdev = pdata->dfl_cdev;
> > +
> > +/* add mmio resource */
> > +parent_res = &pdev->resource[feature->resource_index];
> > +ddev->mmio_res.flags = IORESOURCE_MEM;
> > +ddev->mmio_res.start = parent_res->start;
> > +ddev->mmio_res.end = parent_res->end;
> > +ddev->mmio_res.name = dev_name(&ddev->dev);
> 
> It doesn't reuse the pdev->resource only because it wants a more proper name
> here?

I think yes. To be more precise, this mmio resource is another resource region
owned by the dfl device, although its range is the same as the parent
resource. It is the child of the parent resource. And we could see the
relationship from /proc/iomem. Also we could know exactly from
/proc/iomem which module owns the mem region.

> 
> > +ret = insert_resource(parent_res, &ddev->mmio_res);
> > +if (ret) {
> > +dev_err(&pdev->dev, "%s failed to claim resource: %pR\n",
> > +dev_name(&ddev->dev), &ddev->mmio_res);
> > +goto put_dev;
> > +}
> > +
> > +/* then add irq resource */
> > +if (feature->nr_irqs) {
> > +ddev->irqs = kcalloc(feature->nr_irqs,
> > +     sizeof(*ddev->irqs), GFP_KERNEL);
> > +if (!ddev->irqs) {
> > +ret = -ENOMEM;
> > +goto put_dev;
> > +}
> > +
> > +for (i = 0; i < feature->nr_irqs; i++)
> > +ddev->irqs[i] = feature->irq_ctx[i].irq;
> > +
> > +ddev->num_irqs = feature->nr_irqs;
> > +}
> > +
> > +ret = device_add(&ddev->dev);
> > +if (ret)
> > +goto put_dev;
> > +
> > +dev_info(&pdev->dev, "add dfl_dev: %s\n", dev_name(&ddev->dev));
> > +return ddev;
> > +
> > +put_dev:
> > +/* calls release_dfl_dev() which does the clean up  */
> > +put_device(&ddev->dev);
> > +return ERR_PTR(ret);
> > +}
> > +
> > +static void dfl_devs_uinit(struct dfl_feature_platform_data *pdata)
> > +{
> > +struct dfl_feature *feature;
> > +
> > +dfl_fpga_dev_for_each_feature(pdata, feature) {
> > +if (feature->ddev) {
> > +device_unregister(&feature->ddev->dev);
> > +feature->ddev = NULL;
> > +}
> > +}
> > +}
> > +
> > +static int dfl_devs_init(struct platform_device *pdev)
> > +{
> > +struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev-
> > >dev);
> > +struct dfl_feature *feature;
> > +struct dfl_device *ddev;
> > +int ret;
> > +
> > +dfl_fpga_dev_for_each_feature(pdata, feature) {
> > +if (feature->ioaddr)
> > +continue;
> > +
> > +if (feature->ddev) {
> > +ret = -EBUSY;
> 
> or -EEXIST

Yes, I could change it.

> 
> > +goto err;
> > +}
> > +
> > +ddev = dfl_dev_add(pdata, feature);
> > +if (IS_ERR(ddev)) {
> > +ret = PTR_ERR(ddev);
> > +goto err;
> > +}
> > +
> > +feature->ddev = ddev;
> > +}
> > +
> > +return 0;
> > +
> > +err:
> > +dfl_devs_uinit(pdata);
> > +return ret;
> > +}
> > +
> > +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
> > +{
> > +if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> > +return -EINVAL;
> > +
> > +dfl_drv->drv.owner = owner;
> > +dfl_drv->drv.bus = &dfl_bus_type;
> > +
> > +return driver_register(&dfl_drv->drv);
> > +}
> > +EXPORT_SYMBOL(__dfl_driver_register);
> > +
> > +void dfl_driver_unregister(struct dfl_driver *dfl_drv)
> > +{
> > +driver_unregister(&dfl_drv->drv);
> > +}
> > +EXPORT_SYMBOL(dfl_driver_unregister);
> > +
> >  #define is_header_feature(feature) ((feature)->id ==
> > FEATURE_ID_FIU_HEADER)
> >
> >  /**
> > @@ -261,12 +494,15 @@ void dfl_fpga_dev_feature_uinit(struct
> > platform_device *pdev)
> >  struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev-
> > >dev);
> >  struct dfl_feature *feature;
> >
> > -dfl_fpga_dev_for_each_feature(pdata, feature)
> > +dfl_devs_uinit(pdata);
> 
> Or it's better to rename as dfl_devs_remove(pdata) or something?

I could change it.

> 
> > +
> > +dfl_fpga_dev_for_each_feature(pdata, feature) {
> >  if (feature->ops) {
> >  if (feature->ops->uinit)
> >  feature->ops->uinit(pdev, feature);
> >  feature->ops = NULL;
> >  }
> > +}
> >  }
> >  EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit);
> >
> > @@ -347,6 +583,10 @@ int dfl_fpga_dev_feature_init(struct
> > platform_device *pdev,
> >  drv++;
> >  }
> >
> > +ret = dfl_devs_init(pdev);
> > +if (ret)
> > +goto exit;
> > +
> >  return 0;
> >  exit:
> >  dfl_fpga_dev_feature_uinit(pdev);
> > @@ -1282,11 +1522,17 @@ static int __init dfl_fpga_init(void)
> >  {
> >  int ret;
> >
> > +ret = bus_register(&dfl_bus_type);
> > +if (ret)
> > +return ret;
> > +
> >  dfl_ids_init();
> >
> >  ret = dfl_chardev_init();
> > -if (ret)
> > +if (ret) {
> >  dfl_ids_destroy();
> > +bus_unregister(&dfl_bus_type);
> > +}
> >
> >  return ret;
> >  }
> > @@ -1624,6 +1870,7 @@ static void __exit dfl_fpga_exit(void)
> >  {
> >  dfl_chardev_uinit();
> >  dfl_ids_destroy();
> > +bus_unregister(&dfl_bus_type);
> >  }
> >
> >  module_init(dfl_fpga_init);
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 5973769..d7fd03a 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -246,6 +246,7 @@ struct dfl_feature {
> >  struct dfl_feature_irq_ctx *irq_ctx;
> >  unsigned int nr_irqs;
> >  const struct dfl_feature_ops *ops;
> > +struct dfl_device *ddev;
> 
> Add some description please.

Yes.

> 
> >  void *priv;
> >  };
> >
> > @@ -514,4 +515,88 @@ long dfl_feature_ioctl_set_irq(struct
> > platform_device *pdev,
> >         struct dfl_feature *feature,
> >         unsigned long arg);
> >
> > +/**
> > + * enum dfl_id_type - define the DFL FIU types
> > + */
> > +enum dfl_id_type {
> > +FME_ID,
> > +PORT_ID,
> > +DFL_ID_MAX,
> > +};
> > +
> > +/**
> > + * struct dfl_device_id -  dfl device identifier
> > + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> 
> Only 4 bits used.

I could make the comments more precise.

Thanks,
Yilun.

> 
> Hao
> 
> > + * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> > + * @driver_data: Driver specific data
> > + */
> > +struct dfl_device_id {
> > +u8 type;
> > +u16 feature_id;
> > +unsigned long driver_data;
> > +};
> > +
> > +/**
> > + * struct dfl_device - represent an dfl device on dfl bus
> > + *
> > + * @dev: Generic device interface.
> > + * @id: id of the dfl device
> > + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> > + * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> > + * @mmio_res: MMIO resource of this dfl device.
> > + * @irqs: List of Linux IRQ numbers of this dfl device.
> > + * @num_irqs: number of IRQs supported by this dfl device.
> > + * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
> > + * @id_entry: matched id entry in dfl driver's id table.
> > + */
> > +struct dfl_device {
> > +struct device dev;
> > +int id;
> > +u8 type;
> > +u16 feature_id;
> > +struct resource mmio_res;
> > +int *irqs;
> > +unsigned int num_irqs;
> > +struct dfl_fpga_cdev *cdev;
> > +const struct dfl_device_id *id_entry;
> > +};
> > +
> > +/**
> > + * struct dfl_driver - represent an dfl device driver
> > + *
> > + * @drv: Driver model structure.
> > + * @id_table: Pointer to table of device IDs the driver is interested in.
> > + *      { } member terminated.
> > + * @probe: Mandatory callback for device binding.
> > + * @remove: Callback for device unbinding.
> > + */
> > +struct dfl_driver {
> > +struct device_driver drv;
> > +const struct dfl_device_id *id_table;
> > +
> > +int (*probe)(struct dfl_device *dfl_dev);
> > +void (*remove)(struct dfl_device *dfl_dev);
> > +};
> > +
> > +#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
> > +#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
> > +
> > +/*
> > + * use a macro to avoid include chaining to get THIS_MODULE
> > + */
> > +#define dfl_driver_register(drv) \
> > +__dfl_driver_register(drv, THIS_MODULE)
> > +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner);
> > +void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> > +
> > +/*
> > + * module_dfl_driver() - Helper macro for drivers that don't do
> > + * anything special in module init/exit.  This eliminates a lot of
> > + * boilerplate.  Each module may only use this macro once, and
> > + * calling it replaces module_init() and module_exit()
> > + */
> > +#define module_dfl_driver(__dfl_driver) \
> > +module_driver(__dfl_driver, dfl_driver_register, \
> > +      dfl_driver_unregister)
> > +
> >  #endif /* __FPGA_DFL_H */
> > --
> > 2.7.4
