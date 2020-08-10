Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAB0240821
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Aug 2020 17:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgHJPFa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Aug 2020 11:05:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:64055 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgHJPF0 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 10 Aug 2020 11:05:26 -0400
IronPort-SDR: w3uJg4T6Vyr5j6rY/hgmVjSsXWGvJGZBGCRdnt0bfMGg+MQ8kCVdol4UPQywapxCh08wOWNscl
 Ti/eD9se5hHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="217884709"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="217884709"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 08:05:21 -0700
IronPort-SDR: ElLQgRYxJQiNjvz5KIoGiqWtkprAHqL/ij/co47GtcGdOzW2XCuXuJqLbF8bshd6ZpVr1+jADJ
 MDy3A8M1GWKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="277299865"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2020 08:05:18 -0700
Date:   Mon, 10 Aug 2020 23:01:43 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH v4 2/4] fpga: dfl: map feature mmio resources in their
 own  feature drivers
Message-ID: <20200810150143.GA5813@yilunxu-OptiPlex-7050>
References: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
 <1597027273-25288-3-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB381930E9699B086D37C27C4585440@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB381930E9699B086D37C27C4585440@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 10, 2020 at 01:56:44PM +0800, Wu, Hao wrote:
> > -----Original Message-----
> > From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
> > On Behalf Of Xu Yilun
> > Sent: Monday, August 10, 2020 10:41 AM
> > To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> > Wu, Hao <hao.wu@intel.com>; Matthew Gerlach
> > <matthew.gerlach@linux.intel.com>; Weight, Russell H
> > <russell.h.weight@intel.com>
> > Subject: [PATCH v4 2/4] fpga: dfl: map feature mmio resources in their own
> > feature drivers
> >
> > This patch makes preparation for modularization of DFL sub feature
> > drivers.
> >
> > Currently, if we need to support a new DFL sub feature, an entry should
> > be added to fme/port_feature_drvs[] in dfl-fme/port-main.c. And we need
> 
> I think it's afu-main.c

Yes, I'll change it.

> 
> > to re-compile the whole DFL modules. That make the DFL drivers hard to be
> > extended.
> 
> And maybe we can drop this description or move it to cover letter as it's not
> the problem this patch is going to resolve.

OK.

> 
> >
> > Another consideration is that DFL may contain some IP blocks which are
> > already supported by kernel, most of them are supported by platform
> > device drivers. We could create platform devices for these IP blocks and
> > get them supported by these drivers.
> >
> > An important issue is that platform device drivers usually requests mmio
> > resources on probe. But now dfl mmio is mapped in dfl bus driver (e.g.
> > dfl-pci) as a whole region. Then platform device drivers for sub features
> > can't request their own mmio resources again. This is what the patch
> > trying to resolve.
> >
> > This patch changes the DFL enumeration. DFL bus driver will unmap mmio
> > resources after first step enumeration and pass enumeration info to DFL
> > framework. Then DFL framework will map the mmio resources again, do 2nd
> > step enumeration, and also unmap the mmio resources. In this way, sub
> > feature drivers could then request their own mmio resources as needed.
> >
> > An exception is that mmio resource of FIU headers are still mapped in dfl
> > bus driver. The FIU headers have some fundamental functions (sriov set,
> > port enable/disable) needed for dfl bus devices and other sub features.
> > They should not be unmapped as long as dfl bus device is alive.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > Acked-by: Wu Hao <hao.wu@intel.com>
> > ---
> > v2: delete dfl_binfo_shift() cause no shift is possible for FIU parsing.
> >     Only map bar0 for first phase enumeration in dfl-pci, we can find
> >       all dfl mmio resource info in bar0.
> >     Some minor fixes for comments from Hao & Tom.
> > v3: no change
> > v4: minor fixes for Hao's comments.
> > ---
> >  drivers/fpga/dfl-pci.c |  24 +++----
> >  drivers/fpga/dfl.c     | 185 +++++++++++++++++++++++++++++++++--------------
> > --
> >  drivers/fpga/dfl.h     |   7 +-
> >  3 files changed, 139 insertions(+), 77 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > index e220bec..a2203d0 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -31,12 +31,12 @@ struct cci_drvdata {
> >  struct dfl_fpga_cdev *cdev;/* container device */
> >  };
> >
> > -static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar)
> > +static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
> >  {
> > -if (pcim_iomap_regions(pcidev, BIT(bar), DRV_NAME))
> > +if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
> >  return NULL;
> >
> > -return pcim_iomap_table(pcidev)[bar];
> > +return pcim_iomap_table(pcidev)[0];
> >  }
> >
> >  static int cci_pci_alloc_irq(struct pci_dev *pcidev)
> > @@ -156,8 +156,8 @@ static int cci_enumerate_feature_devs(struct pci_dev
> > *pcidev)
> >  goto irq_free_exit;
> >  }
> >
> > -/* start to find Device Feature List from Bar 0 */
> > -base = cci_pci_ioremap_bar(pcidev, 0);
> > +/* start to find Device Feature List in Bar 0 */
> > +base = cci_pci_ioremap_bar0(pcidev);
> >  if (!base) {
> >  ret = -ENOMEM;
> >  goto irq_free_exit;
> > @@ -172,7 +172,7 @@ static int cci_enumerate_feature_devs(struct pci_dev
> > *pcidev)
> >  start = pci_resource_start(pcidev, 0);
> >  len = pci_resource_len(pcidev, 0);
> >
> > -dfl_fpga_enum_info_add_dfl(info, start, len, base);
> > +dfl_fpga_enum_info_add_dfl(info, start, len);
> >
> >  /*
> >   * find more Device Feature Lists (e.g. Ports) per information
> > @@ -196,26 +196,24 @@ static int cci_enumerate_feature_devs(struct
> > pci_dev *pcidev)
> >   */
> >  bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> >  offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > -base = cci_pci_ioremap_bar(pcidev, bar);
> > -if (!base)
> > -continue;
> > -
> >  start = pci_resource_start(pcidev, bar) + offset;
> >  len = pci_resource_len(pcidev, bar) - offset;
> >
> > -dfl_fpga_enum_info_add_dfl(info, start, len,
> > -   base + offset);
> > +dfl_fpga_enum_info_add_dfl(info, start, len);
> >  }
> >  } else if (dfl_feature_is_port(base)) {
> >  start = pci_resource_start(pcidev, 0);
> >  len = pci_resource_len(pcidev, 0);
> >
> > -dfl_fpga_enum_info_add_dfl(info, start, len, base);
> > +dfl_fpga_enum_info_add_dfl(info, start, len);
> >  } else {
> >  ret = -ENODEV;
> >  goto irq_free_exit;
> >  }
> >
> > +/* release I/O mappings for next step enumeration */
> > +pcim_iounmap_regions(pcidev, BIT(0));
> > +
> >  /* start enumeration with prepared enumeration information */
> >  cdev = dfl_fpga_feature_devs_enumerate(info);
> >  if (IS_ERR(cdev)) {
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 18575d9..b5257d7 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -250,6 +250,8 @@ int dfl_fpga_check_port_id(struct platform_device
> > *pdev, void *pport_id)
> >  }
> >  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
> >
> > +#define is_header_feature(feature) ((feature)->id ==
> > FEATURE_ID_FIU_HEADER)
> > +
> >  /**
> >   * dfl_fpga_dev_feature_uinit - uinit for sub features of dfl feature device
> >   * @pdev: feature device.
> > @@ -273,8 +275,22 @@ static int dfl_feature_instance_init(struct
> > platform_device *pdev,
> >       struct dfl_feature *feature,
> >       struct dfl_feature_driver *drv)
> >  {
> > +void __iomem *base;
> >  int ret = 0;
> >
> > +if (!is_header_feature(feature)) {
> > +base = devm_platform_ioremap_resource(pdev,
> > +      feature->resource_index);
> > +if (IS_ERR(base)) {
> > +dev_err(&pdev->dev,
> > +"ioremap failed for feature 0x%x!\n",
> > +feature->id);
> > +return PTR_ERR(base);
> > +}
> > +
> > +feature->ioaddr = base;
> > +}
> > +
> >  if (drv->ops->init) {
> >  ret = drv->ops->init(pdev, feature);
> >  if (ret)
> > @@ -427,7 +443,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
> >   * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
> >   *       this device.
> >   * @feature_dev: current feature device.
> > - * @ioaddr: header register region address of feature device in enumeration.
> > + * @ioaddr: header register region address of current FIU in enumeration.
> > + * @start: register resource start of current FIU.
> > + * @len: max register resource length of current FIU.
> >   * @sub_features: a sub features linked list for feature device in
> > enumeration.
> >   * @feature_num: number of sub features for feature device in
> > enumeration.
> >   */
> > @@ -439,6 +457,8 @@ struct build_feature_devs_info {
> >
> >  struct platform_device *feature_dev;
> >  void __iomem *ioaddr;
> > +resource_size_t start;
> > +resource_size_t len;
> >  struct list_head sub_features;
> >  int feature_num;
> >  };
> > @@ -484,10 +504,7 @@ static int build_info_commit_dev(struct
> > build_feature_devs_info *binfo)
> >  struct dfl_feature_platform_data *pdata;
> >  struct dfl_feature_info *finfo, *p;
> >  enum dfl_id_type type;
> > -int ret, index = 0;
> > -
> > -if (!fdev)
> > -return 0;
> > +int ret, index = 0, res_idx = 0;
> >
> >  type = feature_dev_id_type(fdev);
> >  if (WARN_ON_ONCE(type >= DFL_ID_MAX))
> > @@ -530,16 +547,30 @@ static int build_info_commit_dev(struct
> > build_feature_devs_info *binfo)
> >
> >  /* fill features and resource information for feature dev */
> >  list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
> > -struct dfl_feature *feature = &pdata->features[index];
> > +struct dfl_feature *feature = &pdata->features[index++];
> >  struct dfl_feature_irq_ctx *ctx;
> >  unsigned int i;
> >
> >  /* save resource information for each feature */
> >  feature->dev = fdev;
> >  feature->id = finfo->fid;
> > -feature->resource_index = index;
> > -feature->ioaddr = finfo->ioaddr;
> > -fdev->resource[index++] = finfo->mmio_res;
> > +
> > +/*
> > + * map header resource for dfl bus device. Don't add header
> > + * resource to feature devices, or the resource tree will be
> > + * disordered and cause warning on resource release
> 
> I didn't get this description well, could you please explain it a little more
> here?

Yes. I could improve the comments.

The mmio resource of FIU headerS should be owned by dfl bus device
(e.g. dfl-pci), cause they have some fundamental functions (sriov
set, port enable/disable) needed for dfl bus devices and other sub
features. They should not be unmapped as long as dfl bus device is
alive.

So we should not assign them to feature devices (dfl-fme/afu) again.

> 
> > + */
> > +if (is_header_feature(feature)) {
> > +feature->resource_index = -1;
> > +feature->ioaddr =
> > +devm_ioremap_resource(binfo->dev,
> > +      &finfo->mmio_res);
> > +if (IS_ERR(feature->ioaddr))
> > +return PTR_ERR(feature->ioaddr);
> > +} else {
> > +feature->resource_index = res_idx;
> > +fdev->resource[res_idx++] = finfo->mmio_res;
> > +}
> >
> >  if (finfo->nr_irqs) {
> >  ctx = devm_kcalloc(binfo->dev, finfo->nr_irqs,
> > @@ -582,19 +613,13 @@ static int build_info_commit_dev(struct
> > build_feature_devs_info *binfo)
> >
> >  static int
> >  build_info_create_dev(struct build_feature_devs_info *binfo,
> > -      enum dfl_id_type type, void __iomem *ioaddr)
> > +      enum dfl_id_type type)
> >  {
> >  struct platform_device *fdev;
> > -int ret;
> >
> >  if (type >= DFL_ID_MAX)
> >  return -EINVAL;
> >
> > -/* we will create a new device, commit current device first */
> > -ret = build_info_commit_dev(binfo);
> > -if (ret)
> > -return ret;
> > -
> >  /*
> >   * we use -ENODEV as the initialization indicator which indicates
> >   * whether the id need to be reclaimed
> > @@ -605,7 +630,7 @@ build_info_create_dev(struct
> > build_feature_devs_info *binfo,
> >
> >  binfo->feature_dev = fdev;
> >  binfo->feature_num = 0;
> > -binfo->ioaddr = ioaddr;
> > +
> >  INIT_LIST_HEAD(&binfo->sub_features);
> >
> >  fdev->id = dfl_id_alloc(type, &fdev->dev);
> > @@ -747,18 +772,17 @@ static int parse_feature_irqs(struct
> > build_feature_devs_info *binfo,
> >   */
> >  static int
> >  create_feature_instance(struct build_feature_devs_info *binfo,
> > -struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
> > -resource_size_t size, u16 fid)
> > +resource_size_t ofst, resource_size_t size, u16 fid)
> >  {
> >  unsigned int irq_base, nr_irqs;
> >  struct dfl_feature_info *finfo;
> >  int ret;
> >
> >  /* read feature size and id if inputs are invalid */
> > -size = size ? size : feature_size(dfl->ioaddr + ofst);
> > -fid = fid ? fid : feature_id(dfl->ioaddr + ofst);
> > +size = size ? size : feature_size(binfo->ioaddr + ofst);
> > +fid = fid ? fid : feature_id(binfo->ioaddr + ofst);
> >
> > -if (dfl->len - ofst < size)
> > +if (binfo->len - ofst < size)
> >  return -EINVAL;
> >
> >  ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
> > @@ -770,12 +794,11 @@ create_feature_instance(struct
> > build_feature_devs_info *binfo,
> >  return -ENOMEM;
> >
> >  finfo->fid = fid;
> > -finfo->mmio_res.start = dfl->start + ofst;
> > +finfo->mmio_res.start = binfo->start + ofst;
> >  finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
> >  finfo->mmio_res.flags = IORESOURCE_MEM;
> >  finfo->irq_base = irq_base;
> >  finfo->nr_irqs = nr_irqs;
> > -finfo->ioaddr = dfl->ioaddr + ofst;
> >
> >  list_add_tail(&finfo->node, &binfo->sub_features);
> >  binfo->feature_num++;
> > @@ -784,7 +807,6 @@ create_feature_instance(struct
> > build_feature_devs_info *binfo,
> >  }
> >
> >  static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
> > -  struct dfl_fpga_enum_dfl *dfl,
> >    resource_size_t ofst)
> >  {
> >  u64 v = readq(binfo->ioaddr + PORT_HDR_CAP);
> > @@ -792,21 +814,22 @@ static int parse_feature_port_afu(struct
> > build_feature_devs_info *binfo,
> >
> >  WARN_ON(!size);
> >
> > -return create_feature_instance(binfo, dfl, ofst, size,
> > FEATURE_ID_AFU);
> > +return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
> >  }
> >
> > +#define is_feature_dev_detected(binfo) (!!(binfo)->feature_dev)
> > +
> >  static int parse_feature_afu(struct build_feature_devs_info *binfo,
> > -     struct dfl_fpga_enum_dfl *dfl,
> >       resource_size_t ofst)
> >  {
> > -if (!binfo->feature_dev) {
> > +if (!is_feature_dev_detected(binfo)) {
> >  dev_err(binfo->dev, "this AFU does not belong to any
> > FIU.\n");
> >  return -EINVAL;
> >  }
> >
> >  switch (feature_dev_id_type(binfo->feature_dev)) {
> >  case PORT_ID:
> > -return parse_feature_port_afu(binfo, dfl, ofst);
> > +return parse_feature_port_afu(binfo, ofst);
> >  default:
> >  dev_info(binfo->dev, "AFU belonging to FIU %s is not
> > supported yet.\n",
> >   binfo->feature_dev->name);
> > @@ -815,8 +838,39 @@ static int parse_feature_afu(struct
> > build_feature_devs_info *binfo,
> >  return 0;
> >  }
> >
> > +static int dfl_binfo_prepare(struct build_feature_devs_info *binfo,
> > +     resource_size_t start, resource_size_t len)
> > +{
> > +struct device *dev = binfo->dev;
> > +void __iomem *ioaddr;
> > +
> > +if (!devm_request_mem_region(dev, start, len, dev_name(dev))) {
> > +dev_err(dev, "request region fail, start:%pa, len:%pa\n",
> > +&start, &len);
> > +return -EBUSY;
> > +}
> > +
> > +ioaddr = devm_ioremap(dev, start, len);
> > +if (!ioaddr) {
> > +dev_err(dev, "ioremap region fail, start:%pa, len:%pa\n",
> > +&start, &len);
> > +return -ENOMEM;
> > +}
> > +
> > +binfo->start = start;
> > +binfo->len = len;
> > +binfo->ioaddr = ioaddr;
> > +
> > +return 0;
> > +}
> > +
> > +static void dfl_binfo_complete(struct build_feature_devs_info *binfo)
> > +{
> > +devm_iounmap(binfo->dev, binfo->ioaddr);
> > +devm_release_mem_region(binfo->dev, binfo->start, binfo->len);
> > +}
> > +
> >  static int parse_feature_fiu(struct build_feature_devs_info *binfo,
> > -     struct dfl_fpga_enum_dfl *dfl,
> >       resource_size_t ofst)
> >  {
> >  int ret = 0;
> > @@ -824,27 +878,39 @@ static int parse_feature_fiu(struct
> > build_feature_devs_info *binfo,
> >  u16 id;
> >  u64 v;
> >
> > -v = readq(dfl->ioaddr + ofst + DFH);
> > +if (is_feature_dev_detected(binfo)) {
> > +dfl_binfo_complete(binfo);
> 
> Some functions are dfl_bind_xxxx but other are build_info_xxxx.
> If possible, could we unify them using same format? E.g.
> build_info_prepare/complete_xxx

Yes I'll fix them.

> 
> Thanks
> Hao
