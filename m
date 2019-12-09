Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC418116570
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Dec 2019 04:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLIDcS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 8 Dec 2019 22:32:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:52002 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfLIDcS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 8 Dec 2019 22:32:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2019 19:32:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="209979529"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga007.fm.intel.com with ESMTP; 08 Dec 2019 19:32:15 -0800
Date:   Mon, 9 Dec 2019 11:30:11 +0800
From:   Xu Yilum <yilun.xu@intel.com>
To:     mdf@kernel.org, Wu Hao <hao.wu@intel.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: support multiple opens on feature device node.
Message-ID: <20191209033011.GA9673@yilunxu-OptiPlex-7050>
References: <1574054441-1568-1-git-send-email-yilun.xu@intel.com>
 <20191125031524.GA890@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125031524.GA890@hao-dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

Could you please also help us on reviewing this patch when you have
time?

We are working on more DFL improvements like this shared open patch,
also interrupt support and some DFL framework changes are ongoing. So
it would be appreciated we have some feedback for the prepared ones and
not diverge too much for our further developing.

Thanks in advance. :)

On Mon, Nov 25, 2019 at 11:15:24AM +0800, Wu Hao wrote:
> Hi Moritz,
> 
> Could you please help us on review this patch when you have time? Thanks
> in advance. :)
> 
> BTW: This patch was made by Yilun and me, and we already performed some
> review cycles internally before this submission.
> 
> Hao
> 
> On Mon, Nov 18, 2019 at 01:20:41PM +0800, Xu Yilun wrote:
> > Each DFL functional block, e.g. AFU (Accelerated Function Unit) and FME
> > (FPGA Management Engine), could implement more than one function within
> > its region, but current driver only allows one user application to access
> > it by exclusive open on device node. So this is not convenient and
> > flexible for userspace applications, as they have to combine lots of
> > different functions into one single application.
> > 
> > This patch removes the limitation here to allow multiple opens to each
> > feature device node for AFU and FME from userspace applications. If user
> > still needs exclusive access to these device node, O_EXCL flag must be
> > issued together with open.
> > 
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> >  drivers/fpga/dfl-afu-main.c | 26 +++++++++++++++-----------
> >  drivers/fpga/dfl-fme-main.c | 19 ++++++++++++-------
> >  drivers/fpga/dfl.c          | 15 +++++++++++++--
> >  drivers/fpga/dfl.h          | 35 +++++++++++++++++++++++++++--------
> >  4 files changed, 67 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> > index e4a34dc..c6e0e07 100644
> > --- a/drivers/fpga/dfl-afu-main.c
> > +++ b/drivers/fpga/dfl-afu-main.c
> > @@ -561,14 +561,16 @@ static int afu_open(struct inode *inode, struct file *filp)
> >  	if (WARN_ON(!pdata))
> >  		return -ENODEV;
> >  
> > -	ret = dfl_feature_dev_use_begin(pdata);
> > -	if (ret)
> > -		return ret;
> > -
> > -	dev_dbg(&fdev->dev, "Device File Open\n");
> > -	filp->private_data = fdev;
> > +	mutex_lock(&pdata->lock);
> > +	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
> > +	if (!ret) {
> > +		dev_dbg(&fdev->dev, "Device File Opened %d Times\n",
> > +			dfl_feature_dev_use_count(pdata));
> > +		filp->private_data = fdev;
> > +	}
> > +	mutex_unlock(&pdata->lock);
> >  
> > -	return 0;
> > +	return ret;
> >  }
> >  
> >  static int afu_release(struct inode *inode, struct file *filp)
> > @@ -581,12 +583,14 @@ static int afu_release(struct inode *inode, struct file *filp)
> >  	pdata = dev_get_platdata(&pdev->dev);
> >  
> >  	mutex_lock(&pdata->lock);
> > -	__port_reset(pdev);
> > -	afu_dma_region_destroy(pdata);
> > -	mutex_unlock(&pdata->lock);
> > -
> >  	dfl_feature_dev_use_end(pdata);
> >  
> > +	if (!dfl_feature_dev_use_count(pdata)) {
> > +		__port_reset(pdev);
> > +		afu_dma_region_destroy(pdata);
> > +	}
> > +	mutex_unlock(&pdata->lock);
> > +
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > index 7c930e6..fda8623 100644
> > --- a/drivers/fpga/dfl-fme-main.c
> > +++ b/drivers/fpga/dfl-fme-main.c
> > @@ -600,14 +600,16 @@ static int fme_open(struct inode *inode, struct file *filp)
> >  	if (WARN_ON(!pdata))
> >  		return -ENODEV;
> >  
> > -	ret = dfl_feature_dev_use_begin(pdata);
> > -	if (ret)
> > -		return ret;
> > -
> > -	dev_dbg(&fdev->dev, "Device File Open\n");
> > -	filp->private_data = pdata;
> > +	mutex_lock(&pdata->lock);
> > +	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
> > +	if (!ret) {
> > +		dev_dbg(&fdev->dev, "Device File Opened %d Times\n",
> > +			dfl_feature_dev_use_count(pdata));
> > +		filp->private_data = pdata;
> > +	}
> > +	mutex_unlock(&pdata->lock);
> >  
> > -	return 0;
> > +	return ret;
> >  }
> >  
> >  static int fme_release(struct inode *inode, struct file *filp)
> > @@ -616,7 +618,10 @@ static int fme_release(struct inode *inode, struct file *filp)
> >  	struct platform_device *pdev = pdata->dev;
> >  
> >  	dev_dbg(&pdev->dev, "Device File Release\n");
> > +
> > +	mutex_lock(&pdata->lock);
> >  	dfl_feature_dev_use_end(pdata);
> > +	mutex_unlock(&pdata->lock);
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 96a2b82..9909948 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -1079,6 +1079,7 @@ static int __init dfl_fpga_init(void)
> >   */
> >  int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
> >  {
> > +	struct dfl_feature_platform_data *pdata;
> >  	struct platform_device *port_pdev;
> >  	int ret = -ENODEV;
> >  
> > @@ -1093,7 +1094,11 @@ int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
> >  		goto put_dev_exit;
> >  	}
> >  
> > -	ret = dfl_feature_dev_use_begin(dev_get_platdata(&port_pdev->dev));
> > +	pdata = dev_get_platdata(&port_pdev->dev);
> > +
> > +	mutex_lock(&pdata->lock);
> > +	ret = dfl_feature_dev_use_begin(pdata, true);
> > +	mutex_unlock(&pdata->lock);
> >  	if (ret)
> >  		goto put_dev_exit;
> >  
> > @@ -1120,6 +1125,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_release_port);
> >   */
> >  int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
> >  {
> > +	struct dfl_feature_platform_data *pdata;
> >  	struct platform_device *port_pdev;
> >  	int ret = -ENODEV;
> >  
> > @@ -1138,7 +1144,12 @@ int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
> >  	if (ret)
> >  		goto put_dev_exit;
> >  
> > -	dfl_feature_dev_use_end(dev_get_platdata(&port_pdev->dev));
> > +	pdata = dev_get_platdata(&port_pdev->dev);
> > +
> > +	mutex_lock(&pdata->lock);
> > +	dfl_feature_dev_use_end(pdata);
> > +	mutex_unlock(&pdata->lock);
> > +
> >  	cdev->released_port_num--;
> >  put_dev_exit:
> >  	put_device(&port_pdev->dev);
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 9f0e656..4a9a33c 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -205,8 +205,6 @@ struct dfl_feature {
> >  	const struct dfl_feature_ops *ops;
> >  };
> >  
> > -#define DEV_STATUS_IN_USE	0
> > -
> >  #define FEATURE_DEV_ID_UNUSED	(-1)
> >  
> >  /**
> > @@ -219,8 +217,9 @@ struct dfl_feature {
> >   * @dfl_cdev: ptr to container device.
> >   * @id: id used for this feature device.
> >   * @disable_count: count for port disable.
> > + * @excl_open: set on feature device exclusive open.
> > + * @open_count: count for feature device open.
> >   * @num: number for sub features.
> > - * @dev_status: dev status (e.g. DEV_STATUS_IN_USE).
> >   * @private: ptr to feature dev private data.
> >   * @features: sub features of this feature dev.
> >   */
> > @@ -232,26 +231,46 @@ struct dfl_feature_platform_data {
> >  	struct dfl_fpga_cdev *dfl_cdev;
> >  	int id;
> >  	unsigned int disable_count;
> > -	unsigned long dev_status;
> > +	bool excl_open;
> > +	int open_count;
> >  	void *private;
> >  	int num;
> >  	struct dfl_feature features[0];
> >  };
> >  
> >  static inline
> > -int dfl_feature_dev_use_begin(struct dfl_feature_platform_data *pdata)
> > +int dfl_feature_dev_use_begin(struct dfl_feature_platform_data *pdata,
> > +			      bool excl)
> >  {
> > -	/* Test and set IN_USE flags to ensure file is exclusively used */
> > -	if (test_and_set_bit_lock(DEV_STATUS_IN_USE, &pdata->dev_status))
> > +	if (pdata->excl_open)
> >  		return -EBUSY;
> >  
> > +	if (excl) {
> > +		if (pdata->open_count)
> > +			return -EBUSY;
> > +
> > +		pdata->excl_open = true;
> > +	}
> > +	pdata->open_count++;
> > +
> >  	return 0;
> >  }
> >  
> >  static inline
> >  void dfl_feature_dev_use_end(struct dfl_feature_platform_data *pdata)
> >  {
> > -	clear_bit_unlock(DEV_STATUS_IN_USE, &pdata->dev_status);
> > +	pdata->excl_open = false;
> > +
> > +	if (WARN_ON(pdata->open_count <= 0))
> > +		return;
> > +
> > +	pdata->open_count--;
> > +}
> > +
> > +static inline
> > +int dfl_feature_dev_use_count(struct dfl_feature_platform_data *pdata)
> > +{
> > +	return pdata->open_count;
> >  }
> >  
> >  static inline
> > -- 
> > 2.7.4
