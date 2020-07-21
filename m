Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F2227ABE
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jul 2020 10:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGUIdm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jul 2020 04:33:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:51196 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgGUIdl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 21 Jul 2020 04:33:41 -0400
IronPort-SDR: 0ZmKsv65dzCjaYMo8Ar7qaw2gHKdtC2R/4rV+akaRor6/uASzyowQIrX2VWXkfgg5lte/uikVE
 9BkNirxMVayA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="150074841"
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="150074841"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 01:33:40 -0700
IronPort-SDR: aPNM2sVIiY9V+pIKUD/UPBXIcrCirIbMWgFgXgzSg+nFKWKU85RyHkvQ8y9weKv0zFNAFLK4nO
 buy3NRqfwTgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="301548175"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 21 Jul 2020 01:33:38 -0700
Date:   Tue, 21 Jul 2020 16:30:30 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH 2/2] fpga: dfl: create a dfl bus type to support DFL
  devices
Message-ID: <20200721083030.GG17091@yilunxu-OptiPlex-7050>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-3-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB38195AA712F8089090695CE5857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB38195AA712F8089090695CE5857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 17, 2020 at 06:26:37PM +0800, Wu, Hao wrote:
> > -----Original Message-----
> > From: Xu, Yilun <yilun.xu@intel.com>
> > Sent: Wednesday, July 15, 2020 1:38 PM
> > To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> > Wu, Hao <hao.wu@intel.com>; Matthew Gerlach
> > <matthew.gerlach@linux.intel.com>; Weight, Russell H
> > <russell.h.weight@intel.com>
> > Subject: [PATCH 2/2] fpga: dfl: create a dfl bus type to support DFL devices
> >
> > A new bus type "dfl" is introduced for private features which are not
> > initialized by DFL feature drivers (dfl-fme & dfl-afu drivers). So these
> > private features could be handled by separate driver modules.
> >
> > DFL framework will create DFL devices on enumeration.
> 
> Actually these DFL devices are created in AFU/FME driver initialization or real
> core DFL code, is my understanding correct?

Yes I could change the comments.

> 
> > DFL drivers could
> > be registered on this bus to match these DFL devices. They are matched by
> > dfl type & feature_id.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
> >  drivers/fpga/dfl.c                      | 248 ++++++++++++++++++++++++++++++--
> >  drivers/fpga/dfl.h                      |  85 +++++++++++
> >  3 files changed, 340 insertions(+), 8 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl
> > b/Documentation/ABI/testing/sysfs-bus-dfl
> > new file mode 100644
> > index 0000000..cd00abc
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-dfl
> > @@ -0,0 +1,15 @@
> > +What:/sys/bus/dfl/devices/.../type
> > +Date:March 2020
> > +KernelVersion:5.7
> 
> I guess you need to update the date and target kernel version.

Yes

> 
> > +Contact:Xu Yilun <yilun.xu@intel.com>
> > +Description:Read-only. It returns type of DFL FIU of the device. Now DFL
> > +supports 2 FIU types, 0 for FME, 1 for PORT.
> > +Format: 0x%x
> 
> Or consider just print the string instead here?

I think we don't have to. Keeping it align with dfl_device_id.type may
be better. 

> 
> > +
> > +What:/sys/bus/dfl/devices/.../feature_id
> > +Date:March 2020
> > +KernelVersion:5.7
> 
> Ditto.

Yes

> 
> > +Contact:Xu Yilun <yilun.xu@intel.com>
> > +Description:Read-only. It returns feature identifier local to its DFL FIU
> > +type.
> > +Format: 0x%llx
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 7dc6411..93f9d6d 100644
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
> > @@ -255,6 +249,228 @@ static bool is_header_feature(struct dfl_feature
> > *feature)
> >  return feature->id == FEATURE_ID_FIU_HEADER;
> >  }
> >
> > +static const struct dfl_device_id *
> > +dfl_match_one_device(const struct dfl_device_id *id,
> > +     struct dfl_device *dfl_dev)
> 
> Why start a new line here, it's just 80 char here. : )
> BTW: you can use ddev instead of dfl_dev here for a shorter name.

Yes.

> 
> > +{
> > +if (id->type == dfl_dev->type &&
> > +    id->feature_id == dfl_dev->feature_id)
> > +return id;
> > +
> > +return NULL;
> > +}
> > +
> > +static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> > +{
> > +struct dfl_device *dfl_dev = to_dfl_dev(dev);
> > +struct dfl_driver *dfl_drv = to_dfl_drv(drv);
> > +const struct dfl_device_id *id_entry = dfl_drv->id_table;
> > +
> > +while (id_entry->feature_id) {
> > +if (dfl_match_one_device(id_entry, dfl_dev)) {
> > +dfl_dev->id_entry = id_entry;
> > +return 1;
> > +}
> > +id_entry++;
> > +}
> > +
> > +return 0;
> > +}
> > +
> > +static int dfl_bus_probe(struct device *dev)
> > +{
> > +struct dfl_device *dfl_dev = to_dfl_dev(dev);
> > +struct dfl_driver *dfl_drv = to_dfl_drv(dev->driver);
> > +
> > +return dfl_drv->probe(dfl_dev);
> > +}
> > +
> > +static int dfl_bus_remove(struct device *dev)
> > +{
> > +struct dfl_device *dfl_dev = to_dfl_dev(dev);
> > +struct dfl_driver *dfl_drv = to_dfl_drv(dev->driver);
> > +
> > +if (dfl_drv->remove)
> > +dfl_drv->remove(dfl_dev);
> > +
> > +return 0;
> > +}
> > +
> > +static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> > +{
> > +struct dfl_device *dfl_dev = to_dfl_dev(dev);
> > +
> > +if (add_uevent_var(env, "MODALIAS=dfl:%08x:%016llx",
> > +   dfl_dev->type, dfl_dev->feature_id))
> 
> I see for pci bus, it's using v%08Xd%08X... should we consider adding one
> "t" to indicate that value is for type? Will that be simpler to the users?

Yes I could add the tags, maybe "dfl:t%08xf%016llx". So it will not
cause conflicted modalias if a new id field is added.

> 
> > +return -ENOMEM;
> > +
> > +return 0;
> > +}
> > +
> > +/* show dfl info fields */
> > +#define dfl_info_attr(field, format_string)\
> > +static ssize_t\
> > +field##_show(struct device *dev, struct device_attribute *attr,
> > \
> > +     char *buf)\
> > +{\
> > +struct dfl_device *dfl_dev = to_dfl_dev(dev);\
> > +\
> > +return sprintf(buf, format_string, dfl_dev->field);\
> > +}\
> > +static DEVICE_ATTR_RO(field)
> > +
> > +dfl_info_attr(type, "0x%x\n");
> > +dfl_info_attr(feature_id, "0x%llx\n");
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
> > +struct dfl_device *dfl_dev = to_dfl_dev(dev);
> > +
> > +release_resource(&dfl_dev->mmio_res);
> > +kfree(dfl_dev->irqs);
> > +kfree(dfl_dev);
> > +}
> > +
> > +static struct dfl_device *
> > +dfl_dev_add(struct dfl_feature_platform_data *pdata,
> > +    struct dfl_feature *feature)
> > +{
> > +struct platform_device *pdev = pdata->dev;
> > +struct dfl_device *dfl_dev;
> > +int i, ret;
> > +
> > +dfl_dev = kzalloc(sizeof(*dfl_dev), GFP_KERNEL);
> > +if (!dfl_dev)
> > +return ERR_PTR(-ENOMEM);
> > +
> > +dfl_dev->cdev = pdata->dfl_cdev;
> > +
> > +dfl_dev->mmio_res.parent = &pdev->resource[feature-
> > >resource_index];
> > +dfl_dev->mmio_res.flags = IORESOURCE_MEM;
> > +dfl_dev->mmio_res.start =
> > +pdev->resource[feature->resource_index].start;
> > +dfl_dev->mmio_res.end = pdev->resource[feature-
> > >resource_index].end;
> > +
> > +/* then add irq resource */
> > +if (feature->nr_irqs) {
> > +dfl_dev->irqs = kcalloc(feature->nr_irqs,
> > +sizeof(*dfl_dev->irqs), GFP_KERNEL);
> > +if (!dfl_dev->irqs) {
> > +ret = -ENOMEM;
> > +goto free_dfl_dev;
> > +}
> > +
> > +for (i = 0; i < feature->nr_irqs; i++)
> > +dfl_dev->irqs[i] = feature->irq_ctx[i].irq;
> > +
> > +dfl_dev->num_irqs = feature->nr_irqs;
> > +}
> > +
> > +dfl_dev->type = feature_dev_id_type(pdev);
> > +dfl_dev->feature_id = (unsigned long long)feature->id;
> > +
> > +dfl_dev->dev.parent  = &pdev->dev;
> > +dfl_dev->dev.bus     = &dfl_bus_type;
> > +dfl_dev->dev.release = release_dfl_dev;
> > +dev_set_name(&dfl_dev->dev, "%s.%d", dev_name(&pdev->dev),
> > +     feature->index);
> 
> Or it's better to have a generic name for the device on the bus.

mm.. It is good suggestion, we should have a unified name for dfl
devices.

How about ("dfl.%d.%d", pdev->id, feature->index)

> 
> > +
> > +dfl_dev->mmio_res.name = dev_name(&dfl_dev->dev);
> > +ret = insert_resource(dfl_dev->mmio_res.parent, &dfl_dev-
> > >mmio_res);
> > +if (ret) {
> > +dev_err(&pdev->dev, "%s failed to claim resource: %pR\n",
> > +dev_name(&dfl_dev->dev), &dfl_dev->mmio_res);
> > +goto free_irqs;
> > +}
> > +
> > +ret = device_register(&dfl_dev->dev);
> > +if (ret) {
> > +put_device(&dfl_dev->dev);
> > +return ERR_PTR(ret);
> > +}
> > +
> > +dev_info(&pdev->dev, "add dfl_dev: %s\n",
> > + dev_name(&dfl_dev->dev));
> > +return dfl_dev;
> > +
> > +free_irqs:
> > +kfree(dfl_dev->irqs);
> > +free_dfl_dev:
> > +kfree(dfl_dev);
> > +return ERR_PTR(ret);
> > +}
> > +
> > +static void dfl_devs_uinit(struct dfl_feature_platform_data *pdata)
> > +{
> > +struct dfl_device *dfl_dev;
> > +struct dfl_feature *feature;
> > +
> > +dfl_fpga_dev_for_each_feature(pdata, feature) {
> > +if (!feature->ioaddr && feature->priv) {
> > +dfl_dev = feature->priv;
> > +device_unregister(&dfl_dev->dev);
> > +feature->priv = NULL;
> > +}
> > +}
> > +}
> > +
> > +static int dfl_devs_init(struct platform_device *pdev)
> > +{
> > +struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev-
> > >dev);
> > +struct dfl_feature *feature;
> > +struct dfl_device *dfl_dev;
> > +
> > +dfl_fpga_dev_for_each_feature(pdata, feature) {
> > +if (feature->ioaddr || feature->priv)
> > +continue;
> > +
> > +dfl_dev = dfl_dev_add(pdata, feature);
> > +if (IS_ERR(dfl_dev)) {
> > +dfl_devs_uinit(pdata);
> > +return PTR_ERR(dfl_dev);
> > +}
> > +
> > +feature->priv = dfl_dev;
> 
> If
> 
> > +}
> > +
> > +return 0;
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
> >  /**
> >   * dfl_fpga_dev_feature_uinit - uinit for sub features of dfl feature device
> >   * @pdev: feature device.
> > @@ -264,12 +480,15 @@ void dfl_fpga_dev_feature_uinit(struct
> > platform_device *pdev)
> >  struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev-
> > >dev);
> >  struct dfl_feature *feature;
> >
> > -dfl_fpga_dev_for_each_feature(pdata, feature)
> > +dfl_devs_uinit(pdata);
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
> > @@ -348,6 +567,10 @@ int dfl_fpga_dev_feature_init(struct
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
> > @@ -553,6 +776,8 @@ static int build_info_commit_dev(struct
> > build_feature_devs_info *binfo)
> >  struct dfl_feature_irq_ctx *ctx;
> >  unsigned int i;
> >
> > +feature->index = index;
> > +
> >  /* save resource information for each feature */
> >  feature->dev = fdev;
> >  feature->id = finfo->fid;
> > @@ -1295,11 +1520,17 @@ static int __init dfl_fpga_init(void)
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
> > @@ -1637,6 +1868,7 @@ static void __exit dfl_fpga_exit(void)
> >  {
> >  dfl_chardev_uinit();
> >  dfl_ids_destroy();
> > +bus_unregister(&dfl_bus_type);
> >  }
> >
> >  module_init(dfl_fpga_init);
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index f605c28..d00aa1c 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -229,6 +229,10 @@ struct dfl_feature_irq_ctx {
> >   *
> >   * @dev: ptr to pdev of the feature device which has the sub feature.
> >   * @id: sub feature id.
> > + * @index: unique identifier for an sub feature within the feature device.
> > + *   It is possible that multiply sub features with same feature id are
> > + *   listed in one feature device. So an incremental index (start from 0)
> > + *   is needed to identify each sub feature.
> >   * @resource_index: each sub feature has one mmio resource for its
> > registers.
> >   *    this index is used to find its mmio resource from the
> >   *    feature dev (platform device)'s reources.
> > @@ -241,6 +245,7 @@ struct dfl_feature_irq_ctx {
> >  struct dfl_feature {
> >  struct platform_device *dev;
> >  u64 id;
> > +int index;
> >  int resource_index;
> >  void __iomem *ioaddr;
> >  struct dfl_feature_irq_ctx *irq_ctx;
> > @@ -515,4 +520,84 @@ long dfl_feature_ioctl_set_irq(struct
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
> > + * @feature_id: 64 bits feature identifier local to its DFL FIU type.
> > + * @driver_data: Driver specific data
> > + */
> > +struct dfl_device_id {
> > +unsigned int type;
> > +unsigned long long feature_id;
> > +unsigned long driver_data;
> 
> Seems not used yet for driver_data, or can be in later patch with real users.

I think we may keep this. Cause modpost also need this struct
dfl_device_id, I think it would be better we don't frequently change the
struct to avoid sync problem between kernel & modpost.

> 
> > +};
> > +
> > +/**
> > + * struct dfl_device - represent an dfl device on dfl bus
> > + *
> > + * @dev: Generic device interface.
> > + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> > + * @feature_id: 64 bits feature identifier local to its DFL FIU type.
> > + * @mmio_res: MMIO resource of this dfl device.
> > + * @irqs: List of Linux IRQ numbers of this dfl device.
> > + * @num_irqs: number of IRQs supported by this dfl device.
> > + * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
> > + * @id_entry: matched id entry in dfl driver's id table.
> > + */
> > +struct dfl_device {
> > +struct device dev;
> > +unsigned int type;
> > +unsigned long long feature_id;
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
> > + * @probe: Callback for device binding.
> > + * @remove: Callback for device unbinding.
> > + */
> > +struct dfl_driver {
> > +struct device_driver drv;
> > +const struct dfl_device_id *id_table;
> > +
> > +int (*probe)(struct dfl_device *dfl_dev);
> > +int (*remove)(struct dfl_device *dfl_dev);
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
> > +/* module_dfl_driver() - Helper macro for drivers that don't do
> 
> /*
>  * module_dfl_driver()

Yes

> 
> > + * anything special in module init/exit.  This eliminates a lot of
> > + * boilerplate.  Each module may only use this macro once, and
> > + * calling it replaces module_init() and module_exit()
> > + */
> > +#define module_dfl_driver(__dfl_driver) \
> > +module_driver(__dfl_driver, dfl_driver_register, \
> > +      dfl_driver_unregister)
> > +
> >  #endif /* __FPGA_DFL_H */
> 
> BTW: maybe it's better to have one patch to add a driver using this bus as an example?

Yes I can also sent a dfl_n3000_nios driver in next version

Thanks,
Yilun

> 
> Thanks
> Hao
> 
> > --
> > 2.7.4
