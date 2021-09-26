Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716EF418557
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Sep 2021 03:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhIZBOg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 25 Sep 2021 21:14:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:19789 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhIZBOg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 25 Sep 2021 21:14:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10118"; a="287969906"
X-IronPort-AV: E=Sophos;i="5.85,322,1624345200"; 
   d="scan'208";a="287969906"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2021 18:13:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,322,1624345200"; 
   d="scan'208";a="552314351"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Sep 2021 18:12:57 -0700
Date:   Sun, 26 Sep 2021 09:06:10 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v16 3/5] fpga: image-load: signal eventfd when complete
Message-ID: <20210926010610.GA1339205@yilunxu-OptiPlex-7050>
References: <20210923001056.282790-1-russell.h.weight@intel.com>
 <20210923001056.282790-4-russell.h.weight@intel.com>
 <20210924084947.GC806603@yilunxu-OptiPlex-7050>
 <2c63282d-504c-e428-5048-d0743d8523fa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c63282d-504c-e428-5048-d0743d8523fa@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Sep 24, 2021 at 02:45:57PM -0700, Russ Weight wrote:
> 
> 
> On 9/24/21 1:49 AM, Xu Yilun wrote:
> > On Wed, Sep 22, 2021 at 05:10:54PM -0700, Russ Weight wrote:
> >> Amend the FPGA_IMAGE_LOAD_WRITE IOCTL implementation to include an
> >> eventfd file descriptor as a parameter. The eventfd will be triggered
> >> when the image upload completes.
> >>
> >> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> >> ---
> >> v16:
> >>  - Some cleanup of documentation for the FPGA_IMAGE_LOAD_WRITE IOCTL.
> >> v15:
> >>  - This patch is new to the patch-set, and adds an eventfd to the
> >>    FPGA_IMAGE_LOAD_WRITE IOCTL. The eventfd is signalled upon completion
> >>    of an update.
> >> ---
> >>  Documentation/fpga/fpga-image-load.rst | 12 +++++++-----
> >>  drivers/fpga/fpga-image-load.c         | 22 ++++++++++++++++++++--
> >>  include/linux/fpga/fpga-image-load.h   |  2 ++
> >>  include/uapi/linux/fpga-image-load.h   |  3 ++-
> >>  4 files changed, 31 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
> >> index ba371c7c0ca0..22a455421bb4 100644
> >> --- a/Documentation/fpga/fpga-image-load.rst
> >> +++ b/Documentation/fpga/fpga-image-load.rst
> >> @@ -27,8 +27,10 @@ ioctl
> >>  
> >>  FPGA_IMAGE_LOAD_WRITE:
> >>  
> >> -Start an image upload with the provided image buffer. This IOCTL returns
> >> -immediately after starting a kernel worker thread to process the image
> >> -upload which could take as long a 40 minutes depending on the actual device
> >> -being updated. This is an exclusive operation; an attempt to start
> >> -concurrent image uploads for the same device will fail with EBUSY.
> >> +Start an image upload with the provided image buffer. This IOCTL returns
> >> +immediately after starting a kernel worker thread to process the image
> >> +upload which could take as long a 40 minutes depending on the actual device
> >> +being updated. This is an exclusive operation; an attempt to start
> > Just curious, there are marks here but seems no change.
> Hmmm - sometimes when fixing up patches, I find it easier to edit
> the patch files (e.g. changing file and symbol names). The patches
> applied cleanly, but I must have forgotten to regenerate them
> before sending them for review.
> 
> >
> >> +concurrent image loads for the same device will fail with EBUSY. An eventfd
> > You want to fix "uploads" to "loads"? But there are many other "upload(s)".
> My preference is upload, because load implies more than transferring
> the data but the data transfer is all that this driver really does.
> I preferred fpga_image_load to fpga_image_upload for the device name,
> just because it was a couple of characters less. I'll change "loads"
> to "uploads" here.

That's fine. This word is initiated in Patch #1 and changed in Patch #2,
which makes me wonder why.

> 
> Do you think I should rename the driver to fpga_image_upload? Or do
> you think the name is OK if it is probably documented?

The name is OK.

Thanks,
Yilun

> 
> - Russ
> >
> > Others look good to me.
> >
> >> +file descriptor parameter is provided to this IOCTL. It will be signalled
> >> +at the completion of the image upload.
> >> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
> >> index 65f553b59011..09164a0258a5 100644
> >> --- a/drivers/fpga/fpga-image-load.c
> >> +++ b/drivers/fpga/fpga-image-load.c
> >> @@ -34,6 +34,7 @@ static void fpga_image_prog_complete(struct fpga_image_load *imgld)
> >>  {
> >>  	mutex_lock(&imgld->lock);
> >>  	imgld->progress = FPGA_IMAGE_PROG_IDLE;
> >> +	eventfd_signal(imgld->finished, 1);
> >>  	mutex_unlock(&imgld->lock);
> >>  }
> >>  
> >> @@ -112,6 +113,8 @@ static void fpga_image_do_load(struct work_struct *work)
> >>  	vfree(imgld->data);
> >>  	imgld->data = NULL;
> >>  	fpga_image_prog_complete(imgld);
> >> +	eventfd_ctx_put(imgld->finished);
> >> +	imgld->finished = NULL;
> >>  }
> >>  
> >>  static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
> >> @@ -119,6 +122,7 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
> >>  {
> >>  	struct fpga_image_write wb;
> >>  	unsigned long minsz;
> >> +	int ret;
> >>  	u8 *buf;
> >>  
> >>  	if (imgld->driver_unload || imgld->progress != FPGA_IMAGE_PROG_IDLE)
> >> @@ -135,13 +139,23 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
> >>  	if (wb.size & 0x3)
> >>  		return -EINVAL;
> >>  
> >> +	if (wb.evtfd < 0)
> >> +		return -EINVAL;
> >> +
> >>  	buf = vzalloc(wb.size);
> >>  	if (!buf)
> >>  		return -ENOMEM;
> >>  
> >>  	if (copy_from_user(buf, u64_to_user_ptr(wb.buf), wb.size)) {
> >> -		vfree(buf);
> >> -		return -EFAULT;
> >> +		ret = -EFAULT;
> >> +		goto exit_free;
> >> +	}
> >> +
> >> +	imgld->finished = eventfd_ctx_fdget(wb.evtfd);
> >> +	if (IS_ERR(imgld->finished)) {
> >> +		ret = PTR_ERR(imgld->finished);
> >> +		imgld->finished = NULL;
> >> +		goto exit_free;
> >>  	}
> >>  
> >>  	imgld->data = buf;
> >> @@ -151,6 +165,10 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
> >>  	queue_work(system_unbound_wq, &imgld->work);
> >>  
> >>  	return 0;
> >> +
> >> +exit_free:
> >> +	vfree(buf);
> >> +	return ret;
> >>  }
> >>  
> >>  static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
> >> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
> >> index 41ab63cf7b20..7d39daa4d921 100644
> >> --- a/include/linux/fpga/fpga-image-load.h
> >> +++ b/include/linux/fpga/fpga-image-load.h
> >> @@ -9,6 +9,7 @@
> >>  
> >>  #include <linux/cdev.h>
> >>  #include <linux/device.h>
> >> +#include <linux/eventfd.h>
> >>  #include <linux/mutex.h>
> >>  #include <linux/types.h>
> >>  #include <uapi/linux/fpga-image-load.h>
> >> @@ -52,6 +53,7 @@ struct fpga_image_load {
> >>  	u32 progress;
> >>  	u32 err_code;			/* image load error code */
> >>  	bool driver_unload;
> >> +	struct eventfd_ctx *finished;
> >>  	void *priv;
> >>  };
> >>  
> >> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
> >> index 0382078c5a6c..152a8e1c031f 100644
> >> --- a/include/uapi/linux/fpga-image-load.h
> >> +++ b/include/uapi/linux/fpga-image-load.h
> >> @@ -38,7 +38,7 @@
> >>   *				struct fpga_image_write)
> >>   *
> >>   * Upload a data buffer to the target device. The user must provide the
> >> - * data buffer and size.
> >> + * data buffer, size, and an eventfd file descriptor.
> >>   *
> >>   * Return: 0 on success, -errno on failure.
> >>   */
> >> @@ -46,6 +46,7 @@ struct fpga_image_write {
> >>  	/* Input */
> >>  	__u32 flags;		/* Zero for now */
> >>  	__u32 size;		/* Data size (in bytes) to be written */
> >> +	__s32 evtfd;		/* File descriptor for completion signal */
> >>  	__u64 buf;		/* User space address of source data */
> >>  };
> >>  
> >> -- 
> >> 2.25.1
