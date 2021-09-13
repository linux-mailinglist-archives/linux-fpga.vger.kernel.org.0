Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88041408874
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Sep 2021 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbhIMJo1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Sep 2021 05:44:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:23056 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231709AbhIMJo1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 13 Sep 2021 05:44:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="285320569"
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="285320569"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 02:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="543088803"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Sep 2021 02:43:06 -0700
Date:   Mon, 13 Sep 2021 17:36:32 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v15 2/6] fpga: image-load: enable image loads
Message-ID: <20210913093632.GC773070@yilunxu-OptiPlex-7050>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-3-russell.h.weight@intel.com>
 <20210910082232.GB754505@yilunxu-OptiPlex-7050>
 <7945b45b-2728-2612-dc28-a848be8207ec@intel.com>
 <20210913064845.GF754505@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210913064845.GF754505@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Sep 13, 2021 at 02:48:45PM +0800, Xu Yilun wrote:
> On Fri, Sep 10, 2021 at 04:18:26PM -0700, Russ Weight wrote:
> > 
> > 
> > On 9/10/21 1:22 AM, Xu Yilun wrote:
> > > On Wed, Sep 08, 2021 at 07:18:42PM -0700, Russ Weight wrote:
> > >> Extend the FPGA Image Load class driver to include IOCTL support
> > >> (FPGA_IMAGE_LOAD_WRITE) for initiating an upload of an image to a device.
> > >> The IOCTL will return immediately, and the update will begin in the
> > >> context of a kernel worker thread.
> > >>
> > >> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > >> ---
> > >> v15:
> > >>  - Compare to previous patch:
> > >>      [PATCH v14 2/6] fpga: sec-mgr: enable secure updates
> > >>  - Changed file, symbol, and config names to reflect the new driver name
> > >>  - Removed update/filename sysfs file and added the FPGA_IMAGE_LOAD_WRITE
> > >>    IOCTL for writing the image data to the FPGA card. The driver no longer
> > >>    uses the request_firmware framework.
> > >>  - Fixed some error return values in fpga_image_load_register()
> > >>  - Removed signed-off/reviewed-by tags
> > >> v14:
> > >>  - Added MAINTAINERS reference for
> > >>    Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> > >>  - Updated ABI documentation date and kernel version
> > >>  - Updated copyright to 2021
> > >> v13:
> > >>   - Change "if (count == 0 || " to "if (!count || "
> > >>   - Improve error message: "Attempt to register without all required ops\n"
> > >> v12:
> > >>   - Updated Date and KernelVersion fields in ABI documentation
> > >>   - Removed size parameter from write_blk() op - it is now up to
> > >>     the lower-level driver to determine the appropriate size and
> > >>     to update smgr->remaining_size accordingly.
> > >> v11:
> > >>   - Fixed a spelling error in a comment
> > >>   - Initialize smgr->err_code and smgr->progress explicitly in
> > >>     fpga_sec_mgr_create() instead of accepting the default 0 value.
> > >> v10:
> > >>   - Rebased to 5.12-rc2 next
> > >>   - Updated Date and KernelVersion in ABI documentation
> > >> v9:
> > >>   - Updated Date and KernelVersion in ABI documentation
> > >> v8:
> > >>   - No change
> > >> v7:
> > >>   - Changed Date in documentation file to December 2020
> > >>   - Changed filename_store() to use kmemdup_nul() instead of
> > >>     kstrndup() and changed the count to not assume a line-return.
> > >> v6:
> > >>   - Changed "security update" to "secure update" in commit message
> > >> v5:
> > >>   - When checking the return values for functions of type enum
> > >>     fpga_sec_err err_code, test for FPGA_SEC_ERR_NONE instead of 0
> > >> v4:
> > >>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
> > >>     and removed unnecessary references to "Intel".
> > >>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> > >> v3:
> > >>   - Removed unnecessary "goto done"
> > >>   - Added a comment to explain imgr->driver_unload in
> > >>     ifpga_sec_mgr_unregister()
> > >> v2:
> > >>   - Bumped documentation date and version
> > >>   - Removed explicit value assignments in enums
> > >>   - Other minor code cleanup per review comments
> > >> ---
> > >>  Documentation/fpga/fpga-image-load.rst |  21 +++
> > >>  MAINTAINERS                            |   1 +
> > >>  drivers/fpga/fpga-image-load.c         | 224 ++++++++++++++++++++++++-
> > >>  include/linux/fpga/fpga-image-load.h   |  29 ++++
> > >>  include/uapi/linux/fpga-image-load.h   |  58 +++++++
> > >>  5 files changed, 329 insertions(+), 4 deletions(-)
> > >>  create mode 100644 include/uapi/linux/fpga-image-load.h
> > >>
> > >> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
> > >> index a6e53ac66026..2ca8d2f0212d 100644
> > >> --- a/Documentation/fpga/fpga-image-load.rst
> > >> +++ b/Documentation/fpga/fpga-image-load.rst
> > >> @@ -8,3 +8,24 @@ The FPGA Image Load class driver provides a common API for user-space
> > >>  tools to manage image uploads to FPGA devices. Device drivers that
> > >>  instantiate the FPGA Image Load class driver will interact with the
> > >>  target device to transfer and authenticate the image data.
> > >> +
> > >> +User API
> > >> +========
> > >> +
> > >> +open
> > >> +----
> > >> +
> > >> +An FPGA Image Load device is opened exclusively to control an image load.
> > >> +Image loads are processed by a kernel worker thread. A user may choose
> > >> +close the device while the upload continues.
> > > Why we allow the user to close the dev while the uploading is ongoing?
> > > Seems it introduces more checking effort when another user open the dev
> > > again and try another uploading.
> > 
> > A user could choose to write their own tools. How would we prevent
> > them from closing the device while an update is in progress? Should
> > we attempt to cancel the update if they close the device?
> 
> I think we could try to cancel the update when close(), if we cannot
> cancel we block on close().
> 
> The driver should be responsible for the integrity of the update flow,
> it is not prefered a user starts an update and leaves, but canceled by
> another user.
> 
> > 
> > Concurrent updates are already prevented by returning EBUSY for the
> > FPGA_IMAGE_LOAD_WRITE IOCTL if an update is already in progress.
> > 
> > A single IOCTL is sufficient to do a full update. Maybe a user
> > would want to have three small tools: update_start, update_status,
> > update_cancel, each of which would open the device, do an IOCTL,
> > and then close the device. This is analogous to the sysfs
> > implementation (no open/close that bounds the entire sequence).
> > 
> > With the current design, we do an exclusive open. As long as the user
> > keeps the device open, no other process can open the device to start
> > a new update, cancel, or collect status.
> > 
> > Those are my thoughts. What do you think? Is it OK as is? Or should
> > I make some changes here?
> > 
> > >
> > >> +
> > >> +ioctl
> > >> +-----
> > >> +
> > >> +FPGA_IMAGE_LOAD_WRITE:
> > >> +
> > >> +Start an image load with the provided image buffer. This IOCTL returns
> > >> +immediately after starting a kernel worker thread to process the image load
> > >> +which could take as long a 40 minutes depending on the actual device being
> > >> +updated. This is an exclusive operation; an attempt to start concurrent image
> > >> +load for the same device will fail with EBUSY.
> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> > >> index 4e7f48fa7e5c..637bc003ca81 100644
> > >> --- a/MAINTAINERS
> > >> +++ b/MAINTAINERS
> > >> @@ -7365,6 +7365,7 @@ S:	Maintained
> > >>  F:	Documentation/fpga/fpga-image-load.rst
> > >>  F:	drivers/fpga/fpga-image-load.c
> > >>  F:	include/linux/fpga/fpga-image-load.h
> > >> +F:	include/uapi/linux/fpga-image-load.h
> > >>  
> > >>  FPU EMULATOR
> > >>  M:	Bill Metzenthen <billm@melbpc.org.au>
> > >> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
> > >> index 7d75bbcff541..f5ccfa9dd977 100644
> > >> --- a/drivers/fpga/fpga-image-load.c
> > >> +++ b/drivers/fpga/fpga-image-load.c
> > >> @@ -5,18 +5,181 @@
> > >>   * Copyright (C) 2019-2021 Intel Corporation, Inc.
> > >>   */
> > >>  
> > >> +#include <linux/delay.h>
> > >>  #include <linux/fpga/fpga-image-load.h>
> > >> +#include <linux/fs.h>
> > >> +#include <linux/kernel.h>
> > >>  #include <linux/module.h>
> > >>  #include <linux/slab.h>
> > >> +#include <linux/uaccess.h>
> > >>  #include <linux/vmalloc.h>
> > >>  
> > >>  #define IMAGE_LOAD_XA_LIMIT	XA_LIMIT(0, INT_MAX)
> > >>  static DEFINE_XARRAY_ALLOC(fpga_image_load_xa);
> > >>  
> > >>  static struct class *fpga_image_load_class;
> > >> +static dev_t fpga_image_devt;
> > >>  
> > >>  #define to_image_load(d) container_of(d, struct fpga_image_load, dev)
> > >>  
> > >> +static void fpga_image_dev_error(struct fpga_image_load *imgld,
> > >> +				 enum fpga_image_err err_code)
> > >> +{
> > >> +	imgld->err_code = err_code;
> > >> +	imgld->lops->cancel(imgld);
> > >> +}
> > >> +
> > >> +static void fpga_image_prog_complete(struct fpga_image_load *imgld)
> > >> +{
> > >> +	mutex_lock(&imgld->lock);
> > >> +	imgld->progress = FPGA_IMAGE_PROG_IDLE;
> > >> +	complete_all(&imgld->update_done);
> > >> +	mutex_unlock(&imgld->lock);
> > >> +}
> > >> +
> > >> +static void fpga_image_do_load(struct work_struct *work)
> > >> +{
> > >> +	struct fpga_image_load *imgld;
> > >> +	enum fpga_image_err ret;
> > >> +	u32 size, offset = 0;
> > >> +
> > >> +	imgld = container_of(work, struct fpga_image_load, work);
> > >> +	size = imgld->remaining_size;
> > >> +
> > >> +	get_device(&imgld->dev);
> > >> +	if (!try_module_get(imgld->dev.parent->driver->owner)) {
> > >> +		imgld->err_code = FPGA_IMAGE_ERR_BUSY;
> > >> +		goto idle_exit;
> > >> +	}
> > >> +
> > >> +	imgld->progress = FPGA_IMAGE_PROG_PREPARING;
> > >> +	ret = imgld->lops->prepare(imgld);
> > >> +	if (ret != FPGA_IMAGE_ERR_NONE) {
> > >> +		fpga_image_dev_error(imgld, ret);
> > >> +		goto modput_exit;
> > >> +	}
> > >> +
> > >> +	imgld->progress = FPGA_IMAGE_PROG_WRITING;
> > >> +	while (imgld->remaining_size) {
> > >> +		ret = imgld->lops->write_blk(imgld, offset);
> > >> +		if (ret != FPGA_IMAGE_ERR_NONE) {
> > >> +			fpga_image_dev_error(imgld, ret);
> > >> +			goto done;
> > >> +		}
> > >> +
> > >> +		offset = size - imgld->remaining_size;
> > > The low level driver is required to update the "remaining_size" in
> > > write_blk ops?
> > >
> > > The API seems ambiguous. The framework asks for writing a block of data,
> > > but no block size is specified.
> > 
> > This change was made two or three iterations ago at Richard Gong's
> > suggestion. He asserted that the lower level driver should be in
> > control of the block size (based on write speeds). What do you
> 
> I think it is reasonable.
> 
> > think? Should the class driver impose a fixed size? Or allow the
> 
> But the definition of the API is hard to comprehend, either we input the
> offset & the blk size, or we record them all in imgld structure, is it
> better.
> 
> If the framework provides the blk size, the low level driver could
> return the written size so it could still control its own batch.
> 
> > lower-level driver to determine the size? Is it OK to update
> > remaining_size in the lower-level driver? Or should there be
> > another call-back to request the size?
> >  
> > >
> > >> +	}
> > >> +
> > >> +	imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
> > >> +	ret = imgld->lops->poll_complete(imgld);
> > >> +	if (ret != FPGA_IMAGE_ERR_NONE)
> > >> +		fpga_image_dev_error(imgld, ret);
> > >> +
> > >> +done:
> > >> +	if (imgld->lops->cleanup)
> > >> +		imgld->lops->cleanup(imgld);
> > >> +
> > >> +modput_exit:
> > >> +	module_put(imgld->dev.parent->driver->owner);
> > >> +
> > >> +idle_exit:
> > >> +	/*
> > >> +	 * Note: imgld->remaining_size is left unmodified here to provide
> > >> +	 * additional information on errors. It will be reinitialized when
> > >> +	 * the next image load begins.
> > >> +	 */
> > >> +	vfree(imgld->data);
> > >> +	imgld->data = NULL;
> > >> +	put_device(&imgld->dev);
> > >> +	fpga_image_prog_complete(imgld);
> > >> +}
> > >> +
> > >> +static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
> > >> +				       unsigned long arg)
> > >> +{
> > >> +	struct fpga_image_write wb;
> > >> +	unsigned long minsz;
> > >> +	u8 *buf;
> > >> +
> > >> +	if (imgld->driver_unload || imgld->progress != FPGA_IMAGE_PROG_IDLE)
> > >> +		return -EBUSY;
> > >> +
> > >> +	minsz = offsetofend(struct fpga_image_write, buf);
> > >> +	if (copy_from_user(&wb, (void __user *)arg, minsz))
> > >> +		return -EFAULT;
> > >> +
> > >> +	if (wb.flags)
> > >> +		return -EINVAL;
> > >> +
> > >> +	/* Enforce 32-bit alignment on the write data */
> > >> +	if (wb.size & 0x3)
> > >> +		return -EINVAL;
> > >> +
> > >> +	buf = vzalloc(wb.size);
> > >> +	if (!buf)
> > >> +		return -ENOMEM;
> > >> +
> > >> +	if (copy_from_user(buf, u64_to_user_ptr(wb.buf), wb.size)) {
> > >> +		vfree(buf);
> > >> +		return -EFAULT;
> > >> +	}
> > >> +
> > >> +	imgld->data = buf;
> > >> +	imgld->remaining_size = wb.size;
> > >> +	imgld->err_code = FPGA_IMAGE_ERR_NONE;
> > >> +	imgld->progress = FPGA_IMAGE_PROG_STARTING;
> > >> +	reinit_completion(&imgld->update_done);
> > >> +	schedule_work(&imgld->work);
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
> > >> +				  unsigned long arg)
> > >> +{
> > >> +	struct fpga_image_load *imgld = filp->private_data;
> > >> +	int ret = -ENOTTY;
> > >> +
> > >> +	switch (cmd) {
> > >> +	case FPGA_IMAGE_LOAD_WRITE:
> > >> +		mutex_lock(&imgld->lock);
> > >> +		ret = fpga_image_load_ioctl_write(imgld, arg);
> > >> +		mutex_unlock(&imgld->lock);
> > >> +		break;
> > >> +	}
> > >> +
> > >> +	return ret;
> > >> +}
> > >> +
> > >> +static int fpga_image_load_open(struct inode *inode, struct file *filp)
> > >> +{
> > >> +	struct fpga_image_load *imgld = container_of(inode->i_cdev,
> > >> +						     struct fpga_image_load, cdev);
> > >> +
> > >> +	if (test_and_set_bit(0, &imgld->opened))
> > > Some more flags to add for "opened" field? But the field name indicates
> > > it is a single flag.
> > Can you explain your comment further? I'm not understanding. What
> > "more flags" are you referring to?
> > 
> 
> The test_and_set_bit() makes me feel there are more bits to be
> controlled in "opened" for other purposes. The name "opened" indicates
> this is a single state, maybe you don't have to use bitops for it,
> atomic ops for int maybe better.
> 
> > This test_and_set_bit() operation and the "opened" structure member
> > were borrowed from the production driver implementation. opened is a
> > single value that is expected to be either 1 or 0.
> > 
> > >
> > >> +		return -EBUSY;
> > >> +
> > >> +	filp->private_data = imgld;
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static int fpga_image_load_release(struct inode *inode, struct file *filp)
> > >> +{
> > >> +	struct fpga_image_load *imgld = filp->private_data;
> > >> +
> > >> +	clear_bit(0, &imgld->opened);
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static const struct file_operations fpga_image_load_fops = {
> > >> +	.owner = THIS_MODULE,
> > >> +	.open = fpga_image_load_open,
> > >> +	.release = fpga_image_load_release,
> > >> +	.unlocked_ioctl = fpga_image_load_ioctl,
> > >> +};
> > >> +
> > >>  /**
> > >>   * fpga_image_load_register - create and register an FPGA Image Load Device
> > >>   *
> > >> @@ -33,11 +196,17 @@ fpga_image_load_register(struct device *parent,
> > >>  			 const struct fpga_image_load_ops *lops, void *priv)
> > >>  {
> > >>  	struct fpga_image_load *imgld;
> > >> -	int id, ret;
> > >> +	int ret;
> > >> +
> > >> +	if (!lops || !lops->cancel || !lops->prepare ||
> > >> +	    !lops->write_blk || !lops->poll_complete) {
> > >> +		dev_err(parent, "Attempt to register without all required ops\n");
> > >> +		return ERR_PTR(-ENOMEM);
> > >> +	}
> > >>  
> > >>  	imgld = kzalloc(sizeof(*imgld), GFP_KERNEL);
> > >>  	if (!imgld)
> > >> -		return NULL;
> > >> +		return ERR_PTR(-ENOMEM);
> > > This is the fix for Patch #1? If yes please merge it to Patch #1.
> > Good catch. Yes, I'll move it to patch #1.
> > >
> > >>  
> > >>  	ret = xa_alloc(&fpga_image_load_xa, &imgld->dev.id, imgld, IMAGE_LOAD_XA_LIMIT,
> > >>  		       GFP_KERNEL);
> > >> @@ -48,13 +217,19 @@ fpga_image_load_register(struct device *parent,
> > >>  
> > >>  	imgld->priv = priv;
> > >>  	imgld->lops = lops;
> > >> +	imgld->err_code = FPGA_IMAGE_ERR_NONE;
> > >> +	imgld->progress = FPGA_IMAGE_PROG_IDLE;
> > >> +	init_completion(&imgld->update_done);
> > >> +	INIT_WORK(&imgld->work, fpga_image_do_load);
> > >>  
> > >>  	imgld->dev.class = fpga_image_load_class;
> > >>  	imgld->dev.parent = parent;
> > >> +	imgld->dev.devt = MKDEV(MAJOR(fpga_image_devt), imgld->dev.id);
> > >>  
> > >> -	ret = dev_set_name(&imgld->dev, "fpga_image%d", id);
> > >> +	ret = dev_set_name(&imgld->dev, "fpga_image%d", imgld->dev.id);
> > > Another fix? Please merge it to Patch #1.
> > Yes.
> > 
> > >
> > >>  	if (ret) {
> > >> -		dev_err(parent, "Failed to set device name: fpga_image%d\n", id);
> > >> +		dev_err(parent, "Failed to set device name: fpga_image%d\n",
> > >> +			imgld->dev.id);
> > > Ditto
> > Yes.
> > >
> > >>  		goto error_device;
> > >>  	}
> > >>  
> > >> @@ -64,6 +239,16 @@ fpga_image_load_register(struct device *parent,
> > >>  		return ERR_PTR(ret);
> > >>  	}
> > >>  
> > >> +	cdev_init(&imgld->cdev, &fpga_image_load_fops);
> > >> +	imgld->cdev.owner = parent->driver->owner;
> > >> +	imgld->cdev.kobj.parent = &imgld->dev.kobj;
> > >> +
> > >> +	ret = cdev_add(&imgld->cdev, imgld->dev.devt, 1);
> > >> +	if (ret) {
> > >> +		put_device(&imgld->dev);
> > >> +		return ERR_PTR(ret);
> > >> +	}
> > >> +
> > >>  	return imgld;
> > >>  
> > >>  error_device:
> > >> @@ -83,9 +268,29 @@ EXPORT_SYMBOL_GPL(fpga_image_load_register);
> > >>   *
> > >>   * This function is intended for use in an FPGA Image Load driver's
> > >>   * remove() function.
> > >> + *
> > >> + * For some devices, once authentication of the uploaded image has begun,
> > >> + * the hardware cannot be signaled to stop, and the driver will not exit
> > >> + * until the hardware signals completion.  This could be 30+ minutes of
> > >> + * waiting. The driver_unload flag enables a force-unload of the driver
> > >> + * (e.g. modprobe -r) by signaling the parent driver to exit even if the
> > > How does the driver_unload enables the force unload of the parent
> > > driver? I didn't find the code.
> > 
> > The driver_unload field is tested in the lower-level (parent) driver in
> > m10bmc_sec_poll_complete(), allowing the kernel worker thread to exit
> > even if the firmware update is still in progress.
> 
> I didn't see the signaling implementation here. Maybe you need to move the
> comments somewhere else, or in another patch.

I have another concern. the design requires the low level driver poll
for a field of the input parameter that the framework manages. It is
unnormal, like an implicit cancel call to the driver.

How about the framework explicitly call cancel() when needed? Of cource
we need to declare the cancel() could be called when other callback is
in progress.

Thanks,
Yilun

> 
> Thanks,
> Yilun
> 
> > 
> > >
> > >> + * hardware update is incomplete. The driver_unload flag also prevents
> > >> + * new updates from starting once the unregister process has begun.
> > >>   */
> > >>  void fpga_image_load_unregister(struct fpga_image_load *imgld)
> > >>  {
> > >> +	mutex_lock(&imgld->lock);
> > >> +	imgld->driver_unload = true;
> > >> +	if (imgld->progress == FPGA_IMAGE_PROG_IDLE) {
> > >> +		mutex_unlock(&imgld->lock);
> > >> +		goto unregister;
> > >> +	}
> > >> +
> > >> +	mutex_unlock(&imgld->lock);
> > >> +	wait_for_completion(&imgld->update_done);
> > >> +
> > >> +unregister:
> > >> +	cdev_del(&imgld->cdev);
> > >>  	device_unregister(&imgld->dev);
> > >>  }
> > >>  EXPORT_SYMBOL_GPL(fpga_image_load_unregister);
> > >> @@ -100,19 +305,30 @@ static void fpga_image_load_dev_release(struct device *dev)
> > >>  
> > >>  static int __init fpga_image_load_class_init(void)
> > >>  {
> > >> +	int ret;
> > >>  	pr_info("FPGA Image Load Driver\n");
> > >>  
> > >>  	fpga_image_load_class = class_create(THIS_MODULE, "fpga_image_load");
> > >>  	if (IS_ERR(fpga_image_load_class))
> > >>  		return PTR_ERR(fpga_image_load_class);
> > >>  
> > >> +	ret = alloc_chrdev_region(&fpga_image_devt, 0, MINORMASK,
> > >> +				  "fpga_image_load");
> > >> +	if (ret)
> > >> +		goto exit_destroy_class;
> > >> +
> > >>  	fpga_image_load_class->dev_release = fpga_image_load_dev_release;
> > >>  
> > >>  	return 0;
> > >> +
> > >> +exit_destroy_class:
> > >> +	class_destroy(fpga_image_load_class);
> > >> +	return ret;
> > >>  }
> > >>  
> > >>  static void __exit fpga_image_load_class_exit(void)
> > >>  {
> > >> +	unregister_chrdev_region(fpga_image_devt, MINORMASK);
> > >>  	class_destroy(fpga_image_load_class);
> > >>  	WARN_ON(!xa_empty(&fpga_image_load_xa));
> > >>  }
> > >> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
> > >> index a9cef9e1056b..b3d790e5d943 100644
> > >> --- a/include/linux/fpga/fpga-image-load.h
> > >> +++ b/include/linux/fpga/fpga-image-load.h
> > >> @@ -7,22 +7,51 @@
> > >>  #ifndef _LINUX_FPGA_IMAGE_LOAD_H
> > >>  #define _LINUX_FPGA_IMAGE_LOAD_H
> > >>  
> > >> +#include <linux/cdev.h>
> > >> +#include <linux/completion.h>
> > >>  #include <linux/device.h>
> > >>  #include <linux/mutex.h>
> > >>  #include <linux/types.h>
> > >> +#include <uapi/linux/fpga-image-load.h>
> > >>  
> > >>  struct fpga_image_load;
> > >>  
> > >>  /**
> > >>   * struct fpga_image_load_ops - device specific operations
> > >> + * @prepare:		    Required: Prepare secure update
> > >> + * @write_blk:		    Required: Write a block of data
> > >> + * @poll_complete:	    Required: Check for the completion of the
> > >> + *			    HW authentication/programming process. This
> > >> + *			    function should check for imgld->driver_unload
> > >> + *			    and abort with FPGA_IMAGE_ERR_CANCELED when true.
> > >> + * @cancel:		    Required: Signal HW to cancel update
> > >> + * @cleanup:		    Optional: Complements the prepare()
> > >> + *			    function and is called at the completion
> > >> + *			    of the update, whether success or failure,
> > >> + *			    if the prepare function succeeded.
> > >>   */
> > >>  struct fpga_image_load_ops {
> > >> +	enum fpga_image_err (*prepare)(struct fpga_image_load *imgld);
> > >> +	enum fpga_image_err (*write_blk)(struct fpga_image_load *imgld, u32 offset);
> > >> +	enum fpga_image_err (*poll_complete)(struct fpga_image_load *imgld);
> > >> +	enum fpga_image_err (*cancel)(struct fpga_image_load *imgld);
> > >> +	void (*cleanup)(struct fpga_image_load *imgld);
> > >>  };
> > >>  
> > >>  struct fpga_image_load {
> > >>  	struct device dev;
> > >> +	struct cdev cdev;
> > >>  	const struct fpga_image_load_ops *lops;
> > >>  	struct mutex lock;		/* protect data structure contents */
> > >> +	unsigned long opened;
> > >> +	struct work_struct work;
> > >> +	struct completion update_done;
> > >> +	const u8 *data;				/* pointer to update data */
> > >> +	u32 remaining_size;			/* size remaining to transfer */
> > >> +	enum fpga_image_prog progress;
> > >> +	enum fpga_image_prog err_progress;	/* progress at time of failure */
> > > This field is not used in this patch? So could you introduce it later?
> > Yes - I'll move it. Thanks.
> > >
> > >> +	enum fpga_image_err err_code;		/* image load error code */
> > >> +	bool driver_unload;
> > >>  	void *priv;
> > >>  };
> > >>  
> > >> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
> > >> new file mode 100644
> > >> index 000000000000..4146a0a9e408
> > >> --- /dev/null
> > >> +++ b/include/uapi/linux/fpga-image-load.h
> > >> @@ -0,0 +1,58 @@
> > >> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > >> +/*
> > >> + * Header File for FPGA Image Load User API
> > >> + *
> > >> + * Copyright (C) 2019-2021 Intel Corporation, Inc.
> > >> + *
> > >> + */
> > >> +
> > >> +#ifndef _UAPI_LINUX_FPGA_IMAGE_LOAD_H
> > >> +#define _UAPI_LINUX_FPGA_IMAGE_LOAD_H
> > >> +
> > >> +#include <linux/types.h>
> > >> +#include <linux/ioctl.h>
> > >> +
> > >> +#define FPGA_IMAGE_LOAD_MAGIC 0xB9
> > >> +
> > >> +/* Image load progress codes */
> > >> +enum fpga_image_prog {
> > >> +	FPGA_IMAGE_PROG_IDLE,
> > >> +	FPGA_IMAGE_PROG_STARTING,
> > >> +	FPGA_IMAGE_PROG_PREPARING,
> > >> +	FPGA_IMAGE_PROG_WRITING,
> > >> +	FPGA_IMAGE_PROG_PROGRAMMING,
> > >> +	FPGA_IMAGE_PROG_MAX
> > >> +};
> > >> +
> > >> +/* Image error progress codes */
> > >> +enum fpga_image_err {
> > >> +	FPGA_IMAGE_ERR_NONE,
> > >> +	FPGA_IMAGE_ERR_HW_ERROR,
> > >> +	FPGA_IMAGE_ERR_TIMEOUT,
> > >> +	FPGA_IMAGE_ERR_CANCELED,
> > >> +	FPGA_IMAGE_ERR_BUSY,
> > >> +	FPGA_IMAGE_ERR_INVALID_SIZE,
> > >> +	FPGA_IMAGE_ERR_RW_ERROR,
> > >> +	FPGA_IMAGE_ERR_WEAROUT,
> > >> +	FPGA_IMAGE_ERR_MAX
> > >> +};
> > >> +
> > >> +#define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
> > > Put the cmd word definition under the comments and parameter definition.
> > OK
> > >
> > >> +
> > >> +/**
> > >> + * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
> > >> + *				struct fpga_image_write)
> > >> + *
> > >> + * Upload a data buffer to the target device. The user must provide the
> > >> + * data buffer, size, and an eventfd file descriptor.
> > > I didn't find the eventfd.
> > It is added in a later patch. I'll change the comment accordingly.
> > 
> > Thanks,
> > - Russ
> > >
> > > Thanks,
> > > Yilun
> > >
> > >> + *
> > >> + * Return: 0 on success, -errno on failure.
> > >> + */
> > >> +struct fpga_image_write {
> > >> +	/* Input */
> > >> +	__u32 flags;		/* Zero for now */
> > >> +	__u32 size;		/* Data size (in bytes) to be written */
> > >> +	__u64 buf;		/* User space address of source data */
> > >> +};
> > >> +
> > >> +#endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
> > >> -- 
> > >> 2.25.1
