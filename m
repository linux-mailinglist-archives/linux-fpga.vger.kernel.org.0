Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F5B25EB35
	for <lists+linux-fpga@lfdr.de>; Sun,  6 Sep 2020 00:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgIEWE5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 5 Sep 2020 18:04:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55388 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728589AbgIEWEz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 5 Sep 2020 18:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599343492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krSP1Od3NvD32XLPbchEvpqQvwJQGXJbXl1FT179Xsw=;
        b=FGX80LKITXr8nE/4d6bEALIUYeH/2/HZNuHIHmOPouEsQ6fu+hIkrTSskcrp25VqV3r3Vx
        wPshbI0UCg77f4j6la1e0vaH9XdlFqoz4CI1gi5L65kfJtq2k71+bjSdeHBDGDUZvhelQT
        ASwChaUb1IRHfIIIPXvkn8zz+q9cBLY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-PSBNojrCMKW-NAVsearFlA-1; Sat, 05 Sep 2020 18:04:50 -0400
X-MC-Unique: PSBNojrCMKW-NAVsearFlA-1
Received: by mail-qt1-f199.google.com with SMTP id e11so6586354qth.21
        for <linux-fpga@vger.kernel.org>; Sat, 05 Sep 2020 15:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=krSP1Od3NvD32XLPbchEvpqQvwJQGXJbXl1FT179Xsw=;
        b=C/FCRKg7jFoYKehp9p/DkdzBfzxSm/Y+MgISWszjXfurvhLLYCfvpE4FW+/zFWN9kj
         78+DPAX7kxjSQeqzej4v+7UgG5ulYTbKxc89rYxSwmI6GQXZqxiw/gwWVG1fVjx3iqLV
         Ip+D79Tph2vqLWbHAGAhEmUANn2djAGT2vzi2pyZ3cJFAczXWZWRDdw1ut/Rll8l4m1J
         vfq/wkUEmmf1WJsP/iD+f3vU721Ekm3p96S8yRT1ekm+Oy9jncGujxgsv+3vLDeh2/cN
         rModc6Is7O0xaMMR3sOZSmpqvQ2qw8YR1+LAOyRUPyyZM+UmKmvLoL45qUMX7x9niYRV
         dtuQ==
X-Gm-Message-State: AOAM533aSyiYHZ/aiQrP4S0Cfm5M6odtre9gNwvW70gdiIBa34bjtsGc
        YWjDCUnBM91cR0IYCWrFkSU7wsQn48HHfrkMdIEUIVFBx8j/4lwCvNo1wXgerrHmbXQRCHgBqcM
        N6a3CCEq9TWHAlDrjdnn90w==
X-Received: by 2002:ac8:7b95:: with SMTP id p21mr14622252qtu.139.1599343490069;
        Sat, 05 Sep 2020 15:04:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySRikCCor5yr0BDNe9+iwoIDyju7V6u1adnNggK8GYcJEWS1t2AsE88quSFPb5nSXUZrvyKQ==
X-Received: by 2002:ac8:7b95:: with SMTP id p21mr14622237qtu.139.1599343489711;
        Sat, 05 Sep 2020 15:04:49 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b13sm7617761qkl.46.2020.09.05.15.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 15:04:49 -0700 (PDT)
Subject: Re: [PATCH v1 05/12] fpga: enable secure updates
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-6-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3c3440c3-1087-f1aa-d25f-52156b68020c@redhat.com>
Date:   Sat, 5 Sep 2020 15:04:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-6-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/4/20 4:52 PM, Russ Weight wrote:
> Extend the FPGA Intel Security Manager class driver to
> include an update/filename sysfs node that can be used
> to initiate a security update.  The filename of a secure
> update file (BMC image, FPGA image, Root Entry Hash image,
> or Code Signing Key cancellation image) can be written to
> this sysfs entry to cause a secure update to occur.
>
> The write of the filename will return immediately, and the
> update will begin in the context of a kernel worker thread.
> This tool utilizes the request_firmware framework, which
> requires that the image file reside under /lib/firmware.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     |  13 ++
>  drivers/fpga/ifpga-sec-mgr.c                  | 155 ++++++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            |  49 ++++++
>  3 files changed, 217 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> index 86f8992559bf..a476504b7ae9 100644
> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -73,3 +73,16 @@ Contact:	Russ Weight <russell.h.weight@intel.com>
>  Description:	Read only. Returns number of times the BMC image has been
>  		flashed.
>  		Format: "%d".
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/filename
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Write only. Write the filename of an Intel image
> +		file to this sysfs file to initiate a secure
> +		update. The file must have an appropriate header
> +		which, among other things, identifies the target
> +		for the update. This mechanism is used to update
> +		BMC images, BMC firmware, Static Region images,
> +		and Root Entry Hashes, and to cancel Code Signing
> +		Keys (CSK).
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> index 97bf80277ed2..73173badbe96 100644
> --- a/drivers/fpga/ifpga-sec-mgr.c
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -5,8 +5,11 @@
>   * Copyright (C) 2019-2020 Intel Corporation, Inc.
>   */
>  
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
>  #include <linux/fpga/ifpga-sec-mgr.h>
>  #include <linux/idr.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> @@ -14,6 +17,8 @@
>  static DEFINE_IDA(ifpga_sec_mgr_ida);
>  static struct class *ifpga_sec_mgr_class;
>  
> +#define WRITE_BLOCK_SIZE	0x4000
> +
>  static ssize_t show_canceled_csk(struct ifpga_sec_mgr *imgr,
>  				 sysfs_csk_hndlr_t get_csk,
>  				 sysfs_csk_nbits_t get_csk_nbits,
> @@ -134,6 +139,91 @@ static struct attribute *sec_mgr_security_attrs[] = {
>  	NULL,
>  };
>  
> +static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
> +				enum ifpga_sec_err err_code)
> +{
> +	imgr->err_code = err_code;
> +	imgr->iops->cancel(imgr);
> +}
> +
> +static void progress_complete(struct ifpga_sec_mgr *imgr)
> +{
> +	mutex_lock(&imgr->lock);
> +	imgr->progress = IFPGA_SEC_PROG_IDLE;
> +	complete_all(&imgr->update_done);
> +	mutex_unlock(&imgr->lock);
> +}
> +
> +static void ifpga_sec_mgr_update(struct work_struct *work)
> +{
> +	u32 size, blk_size, offset = 0;
> +	struct ifpga_sec_mgr *imgr;
> +	const struct firmware *fw;
> +	enum ifpga_sec_err ret;
> +
> +	imgr = container_of(work, struct ifpga_sec_mgr, work);

Why not lock here ? It seems like filename and other

state could be changed out from under the work func.

> +
> +	get_device(&imgr->dev);
> +	if (request_firmware(&fw, imgr->filename, &imgr->dev)) {
> +		imgr->err_code = IFPGA_SEC_ERR_FILE_READ;
> +		goto idle_exit;
> +	}
> +
> +	imgr->data = fw->data;
> +	imgr->remaining_size = fw->size;
> +
> +	if (!try_module_get(imgr->dev.parent->driver->owner)) {
> +		imgr->err_code = IFPGA_SEC_ERR_BUSY;
> +		goto release_fw_exit;
> +	}
> +
> +	imgr->progress = IFPGA_SEC_PROG_PREPARING;
> +	ret = imgr->iops->prepare(imgr);
> +	if (ret) {
> +		ifpga_sec_dev_error(imgr, ret);
> +		goto modput_exit;
> +	}
> +
> +	imgr->progress = IFPGA_SEC_PROG_WRITING;
> +	size = imgr->remaining_size;
> +	while (size) {
> +		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
> +		size -= blk_size;
> +		ret = imgr->iops->write_blk(imgr, offset, blk_size);

Check for function pointer later, good.

Could writing a short block be handled like libc's write()

by passing back the bytes written ?

> +		if (ret) {
> +			ifpga_sec_dev_error(imgr, ret);
> +			goto done;
> +		}
> +
> +		imgr->remaining_size = size;
> +		offset += blk_size;
> +	}
> +
> +	imgr->progress = IFPGA_SEC_PROG_PROGRAMMING;
> +	ret = imgr->iops->poll_complete(imgr);
> +	if (ret) {
> +		ifpga_sec_dev_error(imgr, ret);
> +		goto done;
> +	}
Add a paranoid crc check the flash is what was written ?
> +
> +done:
> +	if (imgr->iops->cleanup)
> +		imgr->iops->cleanup(imgr);
> +
> +modput_exit:
> +	module_put(imgr->dev.parent->driver->owner);
> +
> +release_fw_exit:
> +	imgr->data = NULL;
clear remaining_size ?
> +	release_firmware(fw);
> +
> +idle_exit:
> +	kfree(imgr->filename);
> +	imgr->filename = NULL;
> +	put_device(&imgr->dev);
> +	progress_complete(imgr);
> +}
> +
>  #define check_attr(attribute, _name) \
>  	((attribute) == &dev_attr_##_name.attr && imgr->iops->_name)
>  
> @@ -161,6 +251,51 @@ static struct attribute_group sec_mgr_security_attr_group = {
>  	.is_visible = sec_mgr_visible,
>  };
>  
> +static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
> +	int ret = 0;
> +
> +	if (count == 0 || count >= PATH_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&imgr->lock);
> +	if (imgr->driver_unload || imgr->progress != IFPGA_SEC_PROG_IDLE) {
> +		ret = -EBUSY;
> +		goto unlock_exit;
> +	}
> +
> +	imgr->filename = kstrndup(buf, PATH_MAX - 1, GFP_KERNEL);
shouldn't this be 'count - 1' ?
> +	if (!imgr->filename) {
> +		ret = -ENOMEM;
> +		goto unlock_exit;
> +	}
> +
> +	if (imgr->filename[strlen(imgr->filename) - 1] == '\n')
> +		imgr->filename[strlen(imgr->filename) - 1] = '\0';

If you are catching the '\n' is a more general striping of

whitespace needed ?

Could a file exists check be done before kicking off the worker?

> +
> +	imgr->err_code = IFPGA_SEC_ERR_NONE;
> +	imgr->progress = IFPGA_SEC_PROG_READ_FILE;
> +	reinit_completion(&imgr->update_done);
> +	schedule_work(&imgr->work);

Skip the if-check at the end

ret = count.

> +
> +unlock_exit:
> +	mutex_unlock(&imgr->lock);
> +	return ret ? : count;
> +}
> +static DEVICE_ATTR_WO(filename);
> +
> +static struct attribute *sec_mgr_update_attrs[] = {
> +	&dev_attr_filename.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group sec_mgr_update_attr_group = {
> +	.name = "update",
> +	.attrs = sec_mgr_update_attrs,
> +};
> +
>  static ssize_t name_show(struct device *dev,
>  			 struct device_attribute *attr, char *buf)
>  {
> @@ -182,6 +317,7 @@ static struct attribute_group sec_mgr_attr_group = {
>  static const struct attribute_group *ifpga_sec_mgr_attr_groups[] = {
>  	&sec_mgr_attr_group,
>  	&sec_mgr_security_attr_group,
> +	&sec_mgr_update_attr_group,
>  	NULL,
>  };
>  
> @@ -233,6 +369,12 @@ ifpga_sec_mgr_register(struct device *dev, const char *name,
>  	struct ifpga_sec_mgr *imgr;
>  	int id, ret;
>  
> +	if (!iops || !iops->cancel || !iops->prepare ||
> +	    !iops->write_blk || !iops->poll_complete) {
Comments in ifpga-sec-mgr.h say 'Required: ' good.
> +		dev_err(dev, "Attempt to register without ifpga_sec_mgr_ops\n");
without required ifpga_sec_mgr_ops
> +		return NULL;
> +	}
> +
>  	if (!check_reh_handler(dev, iops, bmc) ||
>  	    !check_reh_handler(dev, iops, sr) ||
>  	    !check_reh_handler(dev, iops, pr) ||
> @@ -254,6 +396,8 @@ ifpga_sec_mgr_register(struct device *dev, const char *name,
>  	imgr->name = name;
>  	imgr->priv = priv;
>  	imgr->iops = iops;
> +	init_completion(&imgr->update_done);
> +	INIT_WORK(&imgr->work, ifpga_sec_mgr_update);
>  	mutex_init(&imgr->lock);
>  
>  	id = ida_simple_get(&ifpga_sec_mgr_ida, 0, 0, GFP_KERNEL);
> @@ -299,6 +443,17 @@ void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr)
>  {
>  	dev_info(&imgr->dev, "%s %s\n", __func__, imgr->name);
>  
> +	mutex_lock(&imgr->lock);
> +	imgr->driver_unload = true;
> +	if (imgr->progress == IFPGA_SEC_PROG_IDLE) {
> +		mutex_unlock(&imgr->lock);
> +		goto unregister;
> +	}
> +
> +	mutex_unlock(&imgr->lock);
> +	wait_for_completion(&imgr->update_done);
> +
> +unregister:
>  	device_unregister(&imgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(ifpga_sec_mgr_unregister);
> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
> index e391b0c8f448..4da2864e251c 100644
> --- a/include/linux/fpga/ifpga-sec-mgr.h
> +++ b/include/linux/fpga/ifpga-sec-mgr.h
> @@ -7,6 +7,7 @@
>  #ifndef _LINUX_IFPGA_SEC_MGR_H
>  #define _LINUX_IFPGA_SEC_MGR_H
>  
> +#include <linux/completion.h>
>  #include <linux/device.h>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
> @@ -86,6 +87,19 @@ typedef int (*sysfs_csk_nbits_t)(struct ifpga_sec_mgr *imgr);
>  typedef int (*sysfs_csk_hndlr_t)(struct ifpga_sec_mgr *imgr,
>  				 unsigned long *csk_map, unsigned int nbits);
>  
> +enum ifpga_sec_err {
> +	IFPGA_SEC_ERR_NONE	   = 0x0,
> +	IFPGA_SEC_ERR_HW_ERROR	   = 0x1,
> +	IFPGA_SEC_ERR_TIMEOUT	   = 0x2,
> +	IFPGA_SEC_ERR_CANCELED	   = 0x3,
> +	IFPGA_SEC_ERR_BUSY	   = 0x4,
> +	IFPGA_SEC_ERR_INVALID_SIZE = 0x5,
> +	IFPGA_SEC_ERR_RW_ERROR	   = 0x6,
> +	IFPGA_SEC_ERR_WEAROUT	   = 0x7,
> +	IFPGA_SEC_ERR_FILE_READ	   = 0x8,
> +	IFPGA_SEC_ERR_MAX	   = 0x9
The initializers are redundant.
> +};
> +
>  /**
>   * struct ifpga_sec_mgr_ops - device specific operations
>   * @user_flash_count:	    Optional: Return sysfs string output for FPGA
> @@ -110,6 +124,17 @@ typedef int (*sysfs_csk_hndlr_t)(struct ifpga_sec_mgr *imgr,
>   * @bmc_reh_size:	    Optional: Return byte size for BMC root entry hash
>   * @sr_reh_size:	    Optional: Return byte size for SR root entry hash
>   * @pr_reh_size:	    Optional: Return byte size for PR root entry hash
> + * @prepare:		    Required: Prepare secure update
> + * @write_blk:		    Required: Write a block of data
> + * @poll_complete:	    Required: Check for the completion of the
> + *			    HW authentication/programming process. This
> + *			    function should check for imgr->driver_unload
> + *			    and abort with IFPGA_SEC_ERR_CANCELED when true.
> + * @cancel:		    Required: Signal HW to cancel update
> + * @cleanup:		    Optional: Complements the prepare()
> + *			    function and is called at the completion
> + *			    of the update, whether success or failure,
> + *			    if the prepare function succeeded.
>   */
>  struct ifpga_sec_mgr_ops {
>  	sysfs_cnt_hndlr_t user_flash_count;
> @@ -127,6 +152,22 @@ struct ifpga_sec_mgr_ops {
>  	sysfs_csk_nbits_t bmc_canceled_csk_nbits;
>  	sysfs_csk_nbits_t sr_canceled_csk_nbits;
>  	sysfs_csk_nbits_t pr_canceled_csk_nbits;
> +	enum ifpga_sec_err (*prepare)(struct ifpga_sec_mgr *imgr);
> +	enum ifpga_sec_err (*write_blk)(struct ifpga_sec_mgr *imgr,
> +					u32 offset, u32 size);
> +	enum ifpga_sec_err (*poll_complete)(struct ifpga_sec_mgr *imgr);
> +	void (*cleanup)(struct ifpga_sec_mgr *imgr);
> +	enum ifpga_sec_err (*cancel)(struct ifpga_sec_mgr *imgr);
> +};
> +
> +/* Update progress codes */
> +enum ifpga_sec_prog {
> +	IFPGA_SEC_PROG_IDLE	   = 0x0,
> +	IFPGA_SEC_PROG_READ_FILE   = 0x1,
> +	IFPGA_SEC_PROG_PREPARING   = 0x2,
> +	IFPGA_SEC_PROG_WRITING	   = 0x3,
> +	IFPGA_SEC_PROG_PROGRAMMING = 0x4,
> +	IFPGA_SEC_PROG_MAX	   = 0x5

ditto

Tom

>  };
>  
>  struct ifpga_sec_mgr {
> @@ -134,6 +175,14 @@ struct ifpga_sec_mgr {
>  	struct device dev;
>  	const struct ifpga_sec_mgr_ops *iops;
>  	struct mutex lock;		/* protect data structure contents */
> +	struct work_struct work;
> +	struct completion update_done;
> +	char *filename;
> +	const u8 *data;			/* pointer to update data */
> +	u32 remaining_size;		/* size remaining to transfer */
> +	enum ifpga_sec_prog progress;
> +	enum ifpga_sec_err err_code;	/* security manager error code */
> +	bool driver_unload;
>  	void *priv;
>  };
>  

