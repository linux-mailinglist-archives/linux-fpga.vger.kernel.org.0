Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB957304C
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jul 2019 15:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfGXNyP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Jul 2019 09:54:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:38562 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfGXNyP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Jul 2019 09:54:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 06:54:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="321347618"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga004.jf.intel.com with ESMTP; 24 Jul 2019 06:54:11 -0700
Date:   Wed, 24 Jul 2019 21:37:14 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 03/12] fpga: dfl: pci: enable SRIOV support.
Message-ID: <20190724133714.GC8463@hao-dev>
References: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
 <1563857495-26692-4-git-send-email-hao.wu@intel.com>
 <20190724093744.GC29532@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724093744.GC29532@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jul 24, 2019 at 11:37:44AM +0200, Greg KH wrote:
> On Tue, Jul 23, 2019 at 12:51:26PM +0800, Wu Hao wrote:
> > This patch enables the standard sriov support. It allows user to
> > enable SRIOV (and VFs), then user could pass through accelerators
> > (VFs) into virtual machine or use VFs directly in host.
> > 
> > Signed-off-by: Zhang Yi Z <yi.z.zhang@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Acked-by: Alan Tull <atull@kernel.org>
> > Acked-by: Moritz Fischer <mdf@kernel.org>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > v2: remove DRV/MODULE_VERSION modifications.
> > ---
> >  drivers/fpga/dfl-pci.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  drivers/fpga/dfl.c     | 41 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/fpga/dfl.h     |  1 +
> >  3 files changed, 81 insertions(+)
> > 
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > index 66b5720..0e65d81 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -223,8 +223,46 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
> >  	return ret;
> >  }
> >  
> > +static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
> > +{
> > +	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> > +	struct dfl_fpga_cdev *cdev = drvdata->cdev;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&cdev->lock);
> > +
> > +	if (!num_vfs) {
> > +		/*
> > +		 * disable SRIOV and then put released ports back to default
> > +		 * PF access mode.
> > +		 */
> > +		pci_disable_sriov(pcidev);
> > +
> > +		__dfl_fpga_cdev_config_port_vf(cdev, false);
> > +
> > +	} else if (cdev->released_port_num == num_vfs) {
> > +		/*
> > +		 * only enable SRIOV if cdev has matched released ports, put
> > +		 * released ports into VF access mode firstly.
> > +		 */
> > +		__dfl_fpga_cdev_config_port_vf(cdev, true);
> > +
> > +		ret = pci_enable_sriov(pcidev, num_vfs);
> > +		if (ret)
> > +			__dfl_fpga_cdev_config_port_vf(cdev, false);
> > +	} else {
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	mutex_unlock(&cdev->lock);
> > +	return ret;
> > +}
> > +
> >  static void cci_pci_remove(struct pci_dev *pcidev)
> >  {
> > +	if (dev_is_pf(&pcidev->dev))
> > +		cci_pci_sriov_configure(pcidev, 0);
> > +
> >  	cci_remove_feature_devs(pcidev);
> >  	pci_disable_pcie_error_reporting(pcidev);
> >  }
> > @@ -234,6 +272,7 @@ static void cci_pci_remove(struct pci_dev *pcidev)
> >  	.id_table = cci_pcie_id_tbl,
> >  	.probe = cci_pci_probe,
> >  	.remove = cci_pci_remove,
> > +	.sriov_configure = cci_pci_sriov_configure,
> >  };
> >  
> >  module_pci_driver(cci_pci_driver);
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index e04ed45..c3a8e1d 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -1112,6 +1112,47 @@ int dfl_fpga_cdev_config_port(struct dfl_fpga_cdev *cdev, int port_id,
> >  }
> >  EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_port);
> >  
> > +static void config_port_vf(struct device *fme_dev, int port_id, bool is_vf)
> > +{
> > +	void __iomem *base;
> > +	u64 v;
> > +
> > +	base = dfl_get_feature_ioaddr_by_id(fme_dev, FME_FEATURE_ID_HEADER);
> > +
> > +	v = readq(base + FME_HDR_PORT_OFST(port_id));
> > +
> > +	v &= ~FME_PORT_OFST_ACC_CTRL;
> > +	v |= FIELD_PREP(FME_PORT_OFST_ACC_CTRL,
> > +			is_vf ? FME_PORT_OFST_ACC_VF : FME_PORT_OFST_ACC_PF);
> > +
> > +	writeq(v, base + FME_HDR_PORT_OFST(port_id));
> > +}
> > +
> > +/**
> > + * __dfl_fpga_cdev_config_port_vf - configure port to VF access mode
> > + *
> > + * @cdev: parent container device.
> > + * @if_vf: true for VF access mode, and false for PF access mode
> > + *
> > + * Return: 0 on success, negative error code otherwise.
> > + *
> > + * This function is needed in sriov configuration routine. It could be used to
> > + * configures the released ports access mode to VF or PF.
> > + * The caller needs to hold lock for protection.
> > + */
> > +void __dfl_fpga_cdev_config_port_vf(struct dfl_fpga_cdev *cdev, bool is_vf)
> > +{
> > +	struct dfl_feature_platform_data *pdata;
> > +
> > +	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
> > +		if (device_is_registered(&pdata->dev->dev))
> > +			continue;
> > +
> > +		config_port_vf(cdev->fme_dev, pdata->id, is_vf);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_config_port_vf);
> 
> Why are you exporting a function with a leading __?
> 
> You are expecting someone else, in who knows what code, to do locking
> correctly?  If so, and the caller always has to have a local lock, then
> it's not a big deal, just drop the '__', otherwise if you have to have a
> specific lock for a specific device, then you have a really complex and
> probably broken api here :(

Yes, I just want to remind the user of this API, caller needs to hold the
lock to protect the list. I fully agree, it does make sense to make the
APIs easy to use. I will try to improve this, maybe move the lock inside
this function, then API user doesn't need to know the details of locking.

Thanks a lot for the comments, it really helps.

Hao

> 
> thanks,
> 
> greg k-h
