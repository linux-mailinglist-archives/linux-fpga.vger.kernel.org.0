Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10A1408698
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Sep 2021 10:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbhIMIcj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Sep 2021 04:32:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:27183 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238062AbhIMIc1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 13 Sep 2021 04:32:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="221659194"
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="221659194"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 01:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="507008987"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2021 01:31:08 -0700
Date:   Mon, 13 Sep 2021 16:24:34 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v15 4/6] fpga: image-load: add status ioctl
Message-ID: <20210913082434.GA773070@yilunxu-OptiPlex-7050>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-5-russell.h.weight@intel.com>
 <20210910085005.GC754505@yilunxu-OptiPlex-7050>
 <4ea07b83-f592-749e-80c3-27ed144171bc@intel.com>
 <015f7401-3bf6-e2be-ec53-388e0e9d2fe1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015f7401-3bf6-e2be-ec53-388e0e9d2fe1@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Sep 11, 2021 at 11:12:50AM -0700, Tom Rix wrote:
> 
> On 9/10/21 4:23 PM, Russ Weight wrote:
> > 
> > On 9/10/21 1:50 AM, Xu Yilun wrote:
> > > On Wed, Sep 08, 2021 at 07:18:44PM -0700, Russ Weight wrote:
> > > > Extend the FPGA Image Load class driver to include an
> > > > FPGA_IMAGE_LOAD_STATUS IOCTL that can be used to monitor the progress
> > > > of an ongoing image load.  The status returned includes how much data
> > > > remains to be transferred, the progress of the image load, and error
> > > > information in the case of a failure.
> > > > 
> > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > ---
> > > > V15:
> > > >   - This patch is new to the patchset and provides an FPGA_IMAGE_LOAD_STATUS
> > > >     IOCTL to return the current values for: remaining_size, progress,
> > > >     err_progress, and err_code.
> > > >   - This patch has elements of the following three patches from the previous
> > > >     patch-set:
> > > >       [PATCH v14 3/6] fpga: sec-mgr: expose sec-mgr update status
> > > >       [PATCH v14 4/6] fpga: sec-mgr: expose sec-mgr update errors
> > > >       [PATCH v14 5/6] fpga: sec-mgr: expose sec-mgr update size
> > > >   - Changed file, symbol, and config names to reflect the new driver name
> > > >   - There are some minor changes to locking to enable this ioctl to return
> > > >     coherent data.
> > > > ---
> > > >   Documentation/fpga/fpga-image-load.rst |  6 +++
> > > >   drivers/fpga/fpga-image-load.c         | 53 ++++++++++++++++++++++----
> > > >   include/uapi/linux/fpga-image-load.h   | 18 +++++++++
> > > >   3 files changed, 70 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
> > > > index 739d735592a5..3d5eb51223e3 100644
> > > > --- a/Documentation/fpga/fpga-image-load.rst
> > > > +++ b/Documentation/fpga/fpga-image-load.rst
> > > > @@ -31,3 +31,9 @@ updated. This is an exclusive operation; an attempt to start concurrent image
> > > >   load for the same device will fail with EBUSY. An eventfd file descriptor
> > > >   parameter is provided to this IOCTL, and it will be signalled at the
> > > >   completion of the image load.
> > > > +
> > > > +FPGA_IMAGE_LOAD_STATUS:
> > > > +
> > > > +Collect status for an on-going image upload. The status returned includes
> > > > +how much data remains to be transferred, the progress of the image load,
> > > > +and error information in the case of a failure.
> > > > diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
> > > > index b784456765b0..99a47b21c995 100644
> > > > --- a/drivers/fpga/fpga-image-load.c
> > > > +++ b/drivers/fpga/fpga-image-load.c
> > > > @@ -22,10 +22,27 @@ static dev_t fpga_image_devt;
> > > >   #define to_image_load(d) container_of(d, struct fpga_image_load, dev)
> > > > -static void fpga_image_dev_error(struct fpga_image_load *imgld,
> > > > +static void fpga_image_update_progress(struct fpga_image_load *imgld,
> > > > +				       enum fpga_image_prog new_progress)
> > > > +{
> > > > +	mutex_lock(&imgld->lock);
> > > > +	imgld->progress = new_progress;
> > > > +	mutex_unlock(&imgld->lock);
> > > > +}
> > > > +
> > > > +static void fpga_image_set_error(struct fpga_image_load *imgld,
> > > >   				 enum fpga_image_err err_code)
> > > >   {
> > > > +	mutex_lock(&imgld->lock);
> > > > +	imgld->err_progress = imgld->progress;
> > > >   	imgld->err_code = err_code;
> > > > +	mutex_unlock(&imgld->lock);
> > > > +}
> > > > +
> > > > +static void fpga_image_dev_error(struct fpga_image_load *imgld,
> > > > +				 enum fpga_image_err err_code)
> > > > +{
> > > > +	fpga_image_set_error(imgld, err_code);
> > > >   	imgld->lops->cancel(imgld);
> > > >   }
> > > > @@ -49,18 +66,18 @@ static void fpga_image_do_load(struct work_struct *work)
> > > >   	get_device(&imgld->dev);
> > > >   	if (!try_module_get(imgld->dev.parent->driver->owner)) {
> > > > -		imgld->err_code = FPGA_IMAGE_ERR_BUSY;
> > > > +		fpga_image_set_error(imgld, FPGA_IMAGE_ERR_BUSY);
> > > >   		goto idle_exit;
> > > >   	}
> > > > -	imgld->progress = FPGA_IMAGE_PROG_PREPARING;
> > > > +	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PREPARING);
> > > >   	ret = imgld->lops->prepare(imgld);
> > > >   	if (ret != FPGA_IMAGE_ERR_NONE) {
> > > >   		fpga_image_dev_error(imgld, ret);
> > > >   		goto modput_exit;
> > > >   	}
> > > > -	imgld->progress = FPGA_IMAGE_PROG_WRITING;
> > > > +	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
> > > >   	while (imgld->remaining_size) {
> > > >   		ret = imgld->lops->write_blk(imgld, offset);
> > > >   		if (ret != FPGA_IMAGE_ERR_NONE) {
> > > > @@ -71,7 +88,7 @@ static void fpga_image_do_load(struct work_struct *work)
> > > >   		offset = size - imgld->remaining_size;
> > > >   	}
> > > > -	imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
> > > > +	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
> > > >   	ret = imgld->lops->poll_complete(imgld);
> > > >   	if (ret != FPGA_IMAGE_ERR_NONE)
> > > >   		fpga_image_dev_error(imgld, ret);
> > > > @@ -151,20 +168,42 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
> > > >   	return ret;
> > > >   }
> > > > +static int fpga_image_load_ioctl_status(struct fpga_image_load *imgld,
> > > > +					unsigned long arg)
> > > > +{
> > > > +	struct fpga_image_status status;
> > > > +
> > > > +	memset(&status, 0, sizeof(status));
> > > > +	status.progress = imgld->progress;
> > > > +	status.remaining_size = imgld->remaining_size;
> > > > +	status.err_progress = imgld->err_progress;
> > > > +	status.err_code = imgld->err_code;
> > > > +
> > > > +	if (copy_to_user((void __user *)arg, &status, sizeof(status)))
> > > > +		return -EFAULT;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >   static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
> > > >   				  unsigned long arg)
> > > >   {
> > > >   	struct fpga_image_load *imgld = filp->private_data;
> > > >   	int ret = -ENOTTY;
> > > > +	mutex_lock(&imgld->lock);
> > > > +
> > > >   	switch (cmd) {
> > > >   	case FPGA_IMAGE_LOAD_WRITE:
> > > > -		mutex_lock(&imgld->lock);
> > > >   		ret = fpga_image_load_ioctl_write(imgld, arg);
> > > > -		mutex_unlock(&imgld->lock);
> > > > +		break;
> > > > +	case FPGA_IMAGE_LOAD_STATUS:
> > > > +		ret = fpga_image_load_ioctl_status(imgld, arg);
> > > >   		break;
> > > >   	}
> > > > +	mutex_unlock(&imgld->lock);
> > > > +
> > > >   	return ret;
> > > >   }
> > > > diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
> > > > index a60da115adf5..6a995bcc0fb7 100644
> > > > --- a/include/uapi/linux/fpga-image-load.h
> > > > +++ b/include/uapi/linux/fpga-image-load.h
> > > > @@ -38,6 +38,7 @@ enum fpga_image_err {
> > > >   };
> > > >   #define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
> > > > +#define FPGA_IMAGE_LOAD_STATUS	_IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
> > > >   /**
> > > >    * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
> > > > @@ -56,4 +57,21 @@ struct fpga_image_write {
> > > >   	__u64 buf;		/* User space address of source data */
> > > >   };
> > > > +/**
> > > > + * FPGA_IMAGE_LOAD_STATUS - _IOR(FPGA_IMAGE_LOAD_MAGIC, 1,
> > > > + *				 struct fpga_image_status)
> > > > + *
> > > > + * Request status information for an ongoing update.
> > > > + * data buffer, size, and an eventfd file descriptor.
> > > This line is a typo.
> > Thanks - I'll fix it.
> > > > + *
> > > > + * Return: 0 on success, -errno on failure.
> > > > + */
> > > > +struct fpga_image_status {
> > > > +	/* Output */
> > > > +	__u32 remaining_size;			/* size remaining to transfer */
> > > > +	enum fpga_image_prog progress;		/* current progress of image load */
> > > > +	enum fpga_image_prog err_progress;	/* progress at time of error */
> > > > +	enum fpga_image_err err_code;		/* error code */
> > > Should we use __u32 for these enumeration types?
> > We could, but I did see a lot of uapi header file examples that use
> > enum for IOCTL structures. Is there a reason to prefer __u32? If I change
> > these to __u32, then I suppose I need to change from enum declarations to
> > #define macros?
> 
> The __u32 makes sure the struct is a constant size.
> 
> yes, change the enums to #defines.
> 
> The layout of a new api should be consistent with similar older api.
> 
> review uapi/linux/fpga-dfl.h , the dfl_fpga_port_region_info struct.

Thanks for clarification, yes this is what I expect.

Thanks,
Yilun
