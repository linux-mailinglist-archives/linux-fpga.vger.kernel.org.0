Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9C6156E67
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Feb 2020 05:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgBJEPX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 9 Feb 2020 23:15:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:24199 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgBJEPX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 9 Feb 2020 23:15:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 20:15:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,423,1574150400"; 
   d="scan'208";a="221435237"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga007.jf.intel.com with ESMTP; 09 Feb 2020 20:15:20 -0800
Date:   Mon, 10 Feb 2020 12:13:19 +0800
From:   Xu Yilum <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        hao.wu@intel.com
Subject: Re: [PATCH] fpga: dfl: support multiple opens on feature device node.
Message-ID: <20200210041319.GA11028@yilunxu-OptiPlex-7050>
References: <1574054441-1568-1-git-send-email-yilun.xu@intel.com>
 <20191210020654.GA7171@archbook>
 <20191210085435.GA17198@yilunxu-OptiPlex-7050>
 <20191230073349.GA30202@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230073349.GA30202@yilunxu-OptiPlex-7050>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Dec 30, 2019 at 03:33:49PM +0800, Xu Yilum wrote:
Hi moritz,

Did you get a chance to check this patch? Thanks.

> Hi Moritz:
> 
> Do you have more concern on this patch?
> 
> I've sent a patch v2 for this, fixed minor inline comments.
> 
> Thanks.
> 
> On Tue, Dec 10, 2019 at 04:54:36PM +0800, Xu Yilun wrote:
> > On Mon, Dec 09, 2019 at 06:06:54PM -0800, Moritz Fischer wrote:
> > > Hi Xu,
> > > 
> > > Sorry for the delay.
> > > 
> > > On Mon, Nov 18, 2019 at 01:20:41PM +0800, Xu Yilun wrote:
> > > > Each DFL functional block, e.g. AFU (Accelerated Function Unit) and FME
> > > > (FPGA Management Engine), could implement more than one function within
> > > > its region, but current driver only allows one user application to access
> > > > it by exclusive open on device node. So this is not convenient and
> > > > flexible for userspace applications, as they have to combine lots of
> > > > different functions into one single application.
> > > I'm not entirely sure how I feel about that, wouldn't the right solution
> > > be to create more devices? If this ends up being 100% passthrough
> > > basically, VFIO would be a better choice?
> > 
> > The major issue we want to resolve is how to access the same accelerator by
> > multiple applications. As you know, the accelerator is the dynamic region (AFU)
> > defined by end user, so we don't know how many sub functions end user will
> > implement in the one dynamic region (AFU) of FPGA. So driver can't create devices
> > for logic blocks implemented inside dynamic region.
> > 
> > We don't want 100% passthrough, but only dynamic region (AFU), because for static
> > region part, we can reuse everything, including hardware logics, kernel drivers and
> > upper layer stack/lib/app/tools. Use VFIO PCI directly may not be helpful for our case,
> > and make the device node to support multiple open seems the simplest solution.
> > 
> > > > 
> > > > This patch removes the limitation here to allow multiple opens to each
> > > > feature device node for AFU and FME from userspace applications. If user
> > > > still needs exclusive access to these device node, O_EXCL flag must be
> > > > issued together with open.
> > > Wouldn't you wanna default to have exclusive access, and then allow
> > > multiple opens by means of a management interface, maybe?
> > 
> > I see some examples here which is using O_EXCL flag to indicate exclusive open,
> > like nvram misc driver. I feel this may be a regular method to follow, I believe
> > if we can save one userspace interface with this, that will be simpler for users
> > too.
> > 
> > > > 
> > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > ---
> > > >  drivers/fpga/dfl-afu-main.c | 26 +++++++++++++++-----------
> > > >  drivers/fpga/dfl-fme-main.c | 19 ++++++++++++-------
> > > >  drivers/fpga/dfl.c          | 15 +++++++++++++--
> > > >  drivers/fpga/dfl.h          | 35 +++++++++++++++++++++++++++--------
> > > >  4 files changed, 67 insertions(+), 28 deletions(-)
> > > > 
> > > > diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> > > > index e4a34dc..c6e0e07 100644
> > > > --- a/drivers/fpga/dfl-afu-main.c
> > > > +++ b/drivers/fpga/dfl-afu-main.c
> > > > @@ -561,14 +561,16 @@ static int afu_open(struct inode *inode, struct file *filp)
> > > >  	if (WARN_ON(!pdata))
> > > >  		return -ENODEV;
> > > >  
> > > > -	ret = dfl_feature_dev_use_begin(pdata);
> > > > -	if (ret)
> > > > -		return ret;
> > > > -
> > > > -	dev_dbg(&fdev->dev, "Device File Open\n");
> > > > -	filp->private_data = fdev;
> > > > +	mutex_lock(&pdata->lock);
> > > > +	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
> > > > +	if (!ret) {
> > > > +		dev_dbg(&fdev->dev, "Device File Opened %d Times\n",
> > > > +			dfl_feature_dev_use_count(pdata));
> > > Could those be trace events instead?
> > 
> > I investigated a little to see how we use trace to get this info.
> > 1. config PROFILE_ANNOTATED_BRANCHES in kernel, and add likely()/unlikely()
> >    for ret judgement. This adds some overhead to system.
> > 2. config CONFIG_PROFILE_ALL_BRANCHES, no code change here. This adds
> >    great overhead to system.
> > 3. write a dedicated trace event for this count. I think this is a little
> >    too heavy, we need to add extra file for it, but this count is just
> >    minor info to the driver.
> > 
> > What's your suggestion for this? Could we just leave the print here for
> > simplicity.
> > 
> > 
> > > > +		filp->private_data = fdev;
> > > > +	}
> > > > +	mutex_unlock(&pdata->lock);
> > > >  
> > > > -	return 0;
> > > > +	return ret;
> > > >  }
> > > >  
> > > >  static int afu_release(struct inode *inode, struct file *filp)
> > > > @@ -581,12 +583,14 @@ static int afu_release(struct inode *inode, struct file *filp)
> > > >  	pdata = dev_get_platdata(&pdev->dev);
> > > >  
> > > >  	mutex_lock(&pdata->lock);
> > > > -	__port_reset(pdev);
> > > > -	afu_dma_region_destroy(pdata);
> > > > -	mutex_unlock(&pdata->lock);
> > > > -
> > > >  	dfl_feature_dev_use_end(pdata);
> > > >  
> > > > +	if (!dfl_feature_dev_use_count(pdata)) {
> > > > +		__port_reset(pdev);
> > > > +		afu_dma_region_destroy(pdata);
> > > > +	}
> > > > +	mutex_unlock(&pdata->lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > > > index 7c930e6..fda8623 100644
> > > > --- a/drivers/fpga/dfl-fme-main.c
> > > > +++ b/drivers/fpga/dfl-fme-main.c
> > > > @@ -600,14 +600,16 @@ static int fme_open(struct inode *inode, struct file *filp)
> > > >  	if (WARN_ON(!pdata))
> > > >  		return -ENODEV;
> > > >  
> > > > -	ret = dfl_feature_dev_use_begin(pdata);
> > > > -	if (ret)
> > > > -		return ret;
> > > > -
> > > > -	dev_dbg(&fdev->dev, "Device File Open\n");
> > > > -	filp->private_data = pdata;
> > > > +	mutex_lock(&pdata->lock);
> > > > +	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
> > > > +	if (!ret) {
> > > > +		dev_dbg(&fdev->dev, "Device File Opened %d Times\n",
> > > > +			dfl_feature_dev_use_count(pdata));
> > > > +		filp->private_data = pdata;
> > > > +	}
> > > > +	mutex_unlock(&pdata->lock);
> > > >  
> > > > -	return 0;
> > > > +	return ret;
> > > >  }
> > > >  
> > > >  static int fme_release(struct inode *inode, struct file *filp)
> > > > @@ -616,7 +618,10 @@ static int fme_release(struct inode *inode, struct file *filp)
> > > >  	struct platform_device *pdev = pdata->dev;
> > > >  
> > > >  	dev_dbg(&pdev->dev, "Device File Release\n");
> > > > +
> > > > +	mutex_lock(&pdata->lock);
> > > >  	dfl_feature_dev_use_end(pdata);
> > > > +	mutex_unlock(&pdata->lock);
> > > >  
> > > >  	return 0;
> > > >  }
> > > > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > > > index 96a2b82..9909948 100644
> > > > --- a/drivers/fpga/dfl.c
> > > > +++ b/drivers/fpga/dfl.c
> > > > @@ -1079,6 +1079,7 @@ static int __init dfl_fpga_init(void)
> > > >   */
> > > >  int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
> > > >  {
> > > > +	struct dfl_feature_platform_data *pdata;
> > > >  	struct platform_device *port_pdev;
> > > >  	int ret = -ENODEV;
> > > >  
> > > > @@ -1093,7 +1094,11 @@ int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
> > > >  		goto put_dev_exit;
> > > >  	}
> > > >  
> > > > -	ret = dfl_feature_dev_use_begin(dev_get_platdata(&port_pdev->dev));
> > > > +	pdata = dev_get_platdata(&port_pdev->dev);
> > > > +
> > > > +	mutex_lock(&pdata->lock);
> > > > +	ret = dfl_feature_dev_use_begin(pdata, true);
> > > > +	mutex_unlock(&pdata->lock);
> > > >  	if (ret)
> > > >  		goto put_dev_exit;
> > > >  
> > > > @@ -1120,6 +1125,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_release_port);
> > > >   */
> > > >  int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
> > > >  {
> > > > +	struct dfl_feature_platform_data *pdata;
> > > >  	struct platform_device *port_pdev;
> > > >  	int ret = -ENODEV;
> > > >  
> > > > @@ -1138,7 +1144,12 @@ int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
> > > >  	if (ret)
> > > >  		goto put_dev_exit;
> > > >  
> > > > -	dfl_feature_dev_use_end(dev_get_platdata(&port_pdev->dev));
> > > > +	pdata = dev_get_platdata(&port_pdev->dev);
> > > > +
> > > > +	mutex_lock(&pdata->lock);
> > > > +	dfl_feature_dev_use_end(pdata);
> > > > +	mutex_unlock(&pdata->lock);
> > > > +
> > > >  	cdev->released_port_num--;
> > > >  put_dev_exit:
> > > >  	put_device(&port_pdev->dev);
> > > > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > > > index 9f0e656..4a9a33c 100644
> > > > --- a/drivers/fpga/dfl.h
> > > > +++ b/drivers/fpga/dfl.h
> > > > @@ -205,8 +205,6 @@ struct dfl_feature {
> > > >  	const struct dfl_feature_ops *ops;
> > > >  };
> > > >  
> > > > -#define DEV_STATUS_IN_USE	0
> > > > -
> > > >  #define FEATURE_DEV_ID_UNUSED	(-1)
> > > >  
> > > >  /**
> > > > @@ -219,8 +217,9 @@ struct dfl_feature {
> > > >   * @dfl_cdev: ptr to container device.
> > > >   * @id: id used for this feature device.
> > > >   * @disable_count: count for port disable.
> > > > + * @excl_open: set on feature device exclusive open.
> > > > + * @open_count: count for feature device open.
> > > >   * @num: number for sub features.
> > > > - * @dev_status: dev status (e.g. DEV_STATUS_IN_USE).
> > > >   * @private: ptr to feature dev private data.
> > > >   * @features: sub features of this feature dev.
> > > >   */
> > > > @@ -232,26 +231,46 @@ struct dfl_feature_platform_data {
> > > >  	struct dfl_fpga_cdev *dfl_cdev;
> > > >  	int id;
> > > >  	unsigned int disable_count;
> > > > -	unsigned long dev_status;
> > > > +	bool excl_open;
> > > > +	int open_count;
> > > >  	void *private;
> > > >  	int num;
> > > >  	struct dfl_feature features[0];
> > > >  };
> > > >  
> > > >  static inline
> > > 
> > > > -int dfl_feature_dev_use_begin(struct dfl_feature_platform_data *pdata)
> > > > +int dfl_feature_dev_use_begin(struct dfl_feature_platform_data *pdata,
> > > > +			      bool excl)
> > > >  {
> > > > -	/* Test and set IN_USE flags to ensure file is exclusively used */
> > > > -	if (test_and_set_bit_lock(DEV_STATUS_IN_USE, &pdata->dev_status))
> > > > +	if (pdata->excl_open)
> > > >  		return -EBUSY;
> > > >  
> > > > +	if (excl) {
> > > > +		if (pdata->open_count)
> > > > +			return -EBUSY;
> > > > +
> > > > +		pdata->excl_open = true;
> > > > +	}
> > > > +	pdata->open_count++;
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > >  static inline
> > > >  void dfl_feature_dev_use_end(struct dfl_feature_platform_data *pdata)
> > > >  {
> > > > -	clear_bit_unlock(DEV_STATUS_IN_USE, &pdata->dev_status);
> > > > +	pdata->excl_open = false;
> > > > +
> > > > +	if (WARN_ON(pdata->open_count <= 0))
> > > > +		return;
> > > > +
> > > > +	pdata->open_count--;
> > > > +}
> > > > +
> > > > +static inline
> > > Feel free to drop the inline here. Your compiler will figure that out by
> > > iteself.
> > 
> > Yes I'll change it.
> > 
> > > > +int dfl_feature_dev_use_count(struct dfl_feature_platform_data *pdata)
> > > > +{
> > > > +	return pdata->open_count;
> > > >  }
> > > >  
> > > >  static inline
> > > > -- 
> > > > 2.7.4
> > > > 
> > > 
> > > Again, sorry for the delay,
> > > 
> > > Moritz
> > 
> > Thanks for take your time out :)
> > 
> > Yilun
