Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF35416E4D
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Sep 2021 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbhIXI6Q (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Sep 2021 04:58:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:47196 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244621AbhIXI6Q (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 24 Sep 2021 04:58:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="285043107"
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="285043107"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 01:56:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="514535476"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga008.fm.intel.com with ESMTP; 24 Sep 2021 01:56:32 -0700
Date:   Fri, 24 Sep 2021 16:49:47 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v16 3/5] fpga: image-load: signal eventfd when complete
Message-ID: <20210924084947.GC806603@yilunxu-OptiPlex-7050>
References: <20210923001056.282790-1-russell.h.weight@intel.com>
 <20210923001056.282790-4-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923001056.282790-4-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Sep 22, 2021 at 05:10:54PM -0700, Russ Weight wrote:
> Amend the FPGA_IMAGE_LOAD_WRITE IOCTL implementation to include an
> eventfd file descriptor as a parameter. The eventfd will be triggered
> when the image upload completes.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v16:
>  - Some cleanup of documentation for the FPGA_IMAGE_LOAD_WRITE IOCTL.
> v15:
>  - This patch is new to the patch-set, and adds an eventfd to the
>    FPGA_IMAGE_LOAD_WRITE IOCTL. The eventfd is signalled upon completion
>    of an update.
> ---
>  Documentation/fpga/fpga-image-load.rst | 12 +++++++-----
>  drivers/fpga/fpga-image-load.c         | 22 ++++++++++++++++++++--
>  include/linux/fpga/fpga-image-load.h   |  2 ++
>  include/uapi/linux/fpga-image-load.h   |  3 ++-
>  4 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
> index ba371c7c0ca0..22a455421bb4 100644
> --- a/Documentation/fpga/fpga-image-load.rst
> +++ b/Documentation/fpga/fpga-image-load.rst
> @@ -27,8 +27,10 @@ ioctl
>  
>  FPGA_IMAGE_LOAD_WRITE:
>  
> -Start an image upload with the provided image buffer. This IOCTL returns
> -immediately after starting a kernel worker thread to process the image
> -upload which could take as long a 40 minutes depending on the actual device
> -being updated. This is an exclusive operation; an attempt to start
> -concurrent image uploads for the same device will fail with EBUSY.
> +Start an image upload with the provided image buffer. This IOCTL returns
> +immediately after starting a kernel worker thread to process the image
> +upload which could take as long a 40 minutes depending on the actual device
> +being updated. This is an exclusive operation; an attempt to start

Just curious, there are marks here but seems no change.

> +concurrent image loads for the same device will fail with EBUSY. An eventfd

You want to fix "uploads" to "loads"? But there are many other "upload(s)".

Others look good to me.

> +file descriptor parameter is provided to this IOCTL. It will be signalled
> +at the completion of the image upload.
> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
> index 65f553b59011..09164a0258a5 100644
> --- a/drivers/fpga/fpga-image-load.c
> +++ b/drivers/fpga/fpga-image-load.c
> @@ -34,6 +34,7 @@ static void fpga_image_prog_complete(struct fpga_image_load *imgld)
>  {
>  	mutex_lock(&imgld->lock);
>  	imgld->progress = FPGA_IMAGE_PROG_IDLE;
> +	eventfd_signal(imgld->finished, 1);
>  	mutex_unlock(&imgld->lock);
>  }
>  
> @@ -112,6 +113,8 @@ static void fpga_image_do_load(struct work_struct *work)
>  	vfree(imgld->data);
>  	imgld->data = NULL;
>  	fpga_image_prog_complete(imgld);
> +	eventfd_ctx_put(imgld->finished);
> +	imgld->finished = NULL;
>  }
>  
>  static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
> @@ -119,6 +122,7 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>  {
>  	struct fpga_image_write wb;
>  	unsigned long minsz;
> +	int ret;
>  	u8 *buf;
>  
>  	if (imgld->driver_unload || imgld->progress != FPGA_IMAGE_PROG_IDLE)
> @@ -135,13 +139,23 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>  	if (wb.size & 0x3)
>  		return -EINVAL;
>  
> +	if (wb.evtfd < 0)
> +		return -EINVAL;
> +
>  	buf = vzalloc(wb.size);
>  	if (!buf)
>  		return -ENOMEM;
>  
>  	if (copy_from_user(buf, u64_to_user_ptr(wb.buf), wb.size)) {
> -		vfree(buf);
> -		return -EFAULT;
> +		ret = -EFAULT;
> +		goto exit_free;
> +	}
> +
> +	imgld->finished = eventfd_ctx_fdget(wb.evtfd);
> +	if (IS_ERR(imgld->finished)) {
> +		ret = PTR_ERR(imgld->finished);
> +		imgld->finished = NULL;
> +		goto exit_free;
>  	}
>  
>  	imgld->data = buf;
> @@ -151,6 +165,10 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>  	queue_work(system_unbound_wq, &imgld->work);
>  
>  	return 0;
> +
> +exit_free:
> +	vfree(buf);
> +	return ret;
>  }
>  
>  static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
> index 41ab63cf7b20..7d39daa4d921 100644
> --- a/include/linux/fpga/fpga-image-load.h
> +++ b/include/linux/fpga/fpga-image-load.h
> @@ -9,6 +9,7 @@
>  
>  #include <linux/cdev.h>
>  #include <linux/device.h>
> +#include <linux/eventfd.h>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
>  #include <uapi/linux/fpga-image-load.h>
> @@ -52,6 +53,7 @@ struct fpga_image_load {
>  	u32 progress;
>  	u32 err_code;			/* image load error code */
>  	bool driver_unload;
> +	struct eventfd_ctx *finished;
>  	void *priv;
>  };
>  
> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
> index 0382078c5a6c..152a8e1c031f 100644
> --- a/include/uapi/linux/fpga-image-load.h
> +++ b/include/uapi/linux/fpga-image-load.h
> @@ -38,7 +38,7 @@
>   *				struct fpga_image_write)
>   *
>   * Upload a data buffer to the target device. The user must provide the
> - * data buffer and size.
> + * data buffer, size, and an eventfd file descriptor.
>   *
>   * Return: 0 on success, -errno on failure.
>   */
> @@ -46,6 +46,7 @@ struct fpga_image_write {
>  	/* Input */
>  	__u32 flags;		/* Zero for now */
>  	__u32 size;		/* Data size (in bytes) to be written */
> +	__s32 evtfd;		/* File descriptor for completion signal */
>  	__u64 buf;		/* User space address of source data */
>  };
>  
> -- 
> 2.25.1
