Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3D737961E
	for <lists+linux-fpga@lfdr.de>; Mon, 10 May 2021 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhEJRkO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 May 2021 13:40:14 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:45619 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhEJRkN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 May 2021 13:40:13 -0400
Received: by mail-pj1-f43.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so10782635pjb.4;
        Mon, 10 May 2021 10:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7egdl3K9pNbaxelsUsTvNfhlI99TXAqeXzpphqbSxDg=;
        b=FSiY810IlKo71avBACXHAu8rfCGixetPJNl6ltmlPt9H88A9SpOvN11GpRVVzpC48b
         JkO57SHdi54GQ6IiKo3HGqW1IcvEYpTJpLzkDq/4HZyG7haA7Pof37rHlxvCEoGr39qS
         k0Az3KMbFlmMP6GKQf4zYUxqtewyt/yRw1kUwd/pYjm/5zhI86m2KYxdjcZb+EYhkbIE
         Xs7q1DfsTDekSoA0J38p7Qmeewhye+h+psu8OWtWUtQyMXgDl/oF+yWl1YB2Ave3E5tz
         esmn+BbN4poEYOr/q7OemhHWVqZ8vo1a1GiFubbhf1YQ7Qkh8NkwpzWbAU0oEMMv2EIj
         Zt4w==
X-Gm-Message-State: AOAM530OG1B8WwApQrMHGe/rn1c/S5RNvLoywh9sngeu7nLiEfx9dAKB
        mSM+IN5ilnpjyHuhzoHEwYM=
X-Google-Smtp-Source: ABdhPJyerjB7NaW+VygfDhRE7yV7vMNp18KeGFKI6Fup5WA1FfuL6jvATm3qA0rIvFxGVhSS16akmg==
X-Received: by 2002:a17:90a:a581:: with SMTP id b1mr29110794pjq.53.1620668348375;
        Mon, 10 May 2021 10:39:08 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 21sm8206673pfh.103.2021.05.10.10.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:39:07 -0700 (PDT)
Date:   Mon, 10 May 2021 10:39:06 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v12 4/7] fpga: sec-mgr: expose sec-mgr update errors
Message-ID: <YJlvum8XluSv9Uzy@epycbox.lan>
References: <20210503213546.316439-1-russell.h.weight@intel.com>
 <20210503213546.316439-5-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503213546.316439-5-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 03, 2021 at 02:35:43PM -0700, Russ Weight wrote:
> Extend the FPGA Security Manager class driver to include
> an update/error sysfs node that can be read for error
> information when a secure update fails.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
>   - Changed syntax of sec_mgr_err_str[] array definition from:
> 	"none",			/* FPGA_SEC_ERR_NONE */
>     to:
> 	[FPGA_SEC_ERR_NONE]	    = "none",
> v11:
>   - No change
> v10:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
> v9:
>   - Updated Date and KernelVersion in ABI documentation
> v8:
>   - No change
> v7:
>   - Changed Date in documentation file to December 2020
> v6:
>   - No change
> v5:
>   - Use new function sysfs_emit() in the error_show() function
> v4:
>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>     and removed unnecessary references to "Intel".
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> v3:
>   - Use dev_err() for invalid error code in sec_error()
> v2:
>   - Bumped documentation date and version
>   - Added warning to sec_progress() for invalid progress status
>   - Added sec_error() function (similar to sec_progress())
> ---
>  .../ABI/testing/sysfs-class-fpga-sec-mgr      | 17 ++++
>  drivers/fpga/fpga-sec-mgr.c                   | 83 ++++++++++++++++---
>  include/linux/fpga/fpga-sec-mgr.h             |  1 +
>  3 files changed, 89 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> index b962ad2cf18d..24890d04521f 100644
> --- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> @@ -27,3 +27,20 @@ Description:	Read-only. Returns a string describing the current
>  		programming. Userspace code can poll on this file,
>  		as it will be signaled by sysfs_notify() on each
>  		state change.
> +
> +What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/error
> +Date:		June 2021
> +KernelVersion:	5.14
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. Returns a string describing the failure
> +		of a secure update. This string will be in the form
> +		of <STATUS>:<ERROR>, where <STATUS> will be one of
> +		the status strings described for the status sysfs
> +		file and <ERROR> will be one of the following:
> +		hw-error, timeout, user-abort, device-busy,
> +		invalid-file-size, read-write-error, flash-wearout,
> +		file-read-error.  The error sysfs file is only
> +		meaningful when the secure update engine is in the
> +		idle state. If this file is read while a secure
> +		update is in progress, then the read will fail with
> +		EBUSY.
> diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
> index dec52c68fe16..e43fa2797d27 100644
> --- a/drivers/fpga/fpga-sec-mgr.c
> +++ b/drivers/fpga/fpga-sec-mgr.c
> @@ -30,10 +30,16 @@ static void update_progress(struct fpga_sec_mgr *smgr,
>  	sysfs_notify(&smgr->dev.kobj, "update", "status");
>  }
>  
> +static void set_error(struct fpga_sec_mgr *smgr, enum fpga_sec_err err_code)
> +{
> +	smgr->err_state = smgr->progress;
> +	smgr->err_code = err_code;
> +}

Nit: Could this be fpga_sec_set_error() ?
> +
>  static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
>  			       enum fpga_sec_err err_code)
>  {
> -	smgr->err_code = err_code;
> +	set_error(smgr, err_code);
>  	smgr->sops->cancel(smgr);
>  }
>  
> @@ -56,7 +62,7 @@ static void fpga_sec_mgr_update(struct work_struct *work)
>  
>  	get_device(&smgr->dev);
>  	if (request_firmware(&fw, smgr->filename, &smgr->dev)) {
> -		smgr->err_code = FPGA_SEC_ERR_FILE_READ;
> +		set_error(smgr, FPGA_SEC_ERR_FILE_READ);
>  		goto idle_exit;
>  	}
>  
> @@ -64,7 +70,7 @@ static void fpga_sec_mgr_update(struct work_struct *work)
>  	smgr->remaining_size = fw->size;
>  
>  	if (!try_module_get(smgr->dev.parent->driver->owner)) {
> -		smgr->err_code = FPGA_SEC_ERR_BUSY;
> +		set_error(smgr, FPGA_SEC_ERR_BUSY);
>  		goto release_fw_exit;
>  	}
>  
> @@ -122,24 +128,76 @@ static const char * const sec_mgr_prog_str[] = {
>  	[FPGA_SEC_PROG_PROGRAMMING] = "programming"
>  };
>  
> -static ssize_t
> -status_show(struct device *dev, struct device_attribute *attr, char *buf)
> +static const char * const sec_mgr_err_str[] = {
> +	[FPGA_SEC_ERR_NONE]	    = "none",
> +	[FPGA_SEC_ERR_HW_ERROR]	    = "hw-error",
> +	[FPGA_SEC_ERR_TIMEOUT]	    = "timeout",
> +	[FPGA_SEC_ERR_CANCELED]	    = "user-abort",
> +	[FPGA_SEC_ERR_BUSY]	    = "device-busy",
> +	[FPGA_SEC_ERR_INVALID_SIZE] = "invalid-file-size",
> +	[FPGA_SEC_ERR_RW_ERROR]	    = "read-write-error",
> +	[FPGA_SEC_ERR_WEAROUT]	    = "flash-wearout",
> +	[FPGA_SEC_ERR_FILE_READ]    = "file-read-error"
> +};
> +
> +static const char *sec_progress(struct device *dev, enum fpga_sec_prog prog)
>  {
> -	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
>  	const char *status = "unknown-status";
> -	enum fpga_sec_prog progress;
>  
> -	progress = smgr->progress;
> -	if (progress < FPGA_SEC_PROG_MAX)
> -		status = sec_mgr_prog_str[progress];
> +	if (prog < FPGA_SEC_PROG_MAX)
> +		status = sec_mgr_prog_str[prog];
>  	else
>  		dev_err(dev, "Invalid status during secure update: %d\n",
> -			progress);
> +			prog);
> +
> +	return status;
> +}
> +
> +static const char *sec_error(struct device *dev, enum fpga_sec_err err_code)
> +{
> +	const char *error = "unknown-error";
> +
> +	if (err_code < FPGA_SEC_ERR_MAX)
> +		error = sec_mgr_err_str[err_code];
> +	else
> +		dev_err(dev, "Invalid error code during secure update: %d\n",
> +			err_code);
> +
> +	return error;
> +}
> +
> +static ssize_t
> +status_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
>  
> -	return sysfs_emit(buf, "%s\n", status);
> +	return sysfs_emit(buf, "%s\n", sec_progress(dev, smgr->progress));
>  }
>  static DEVICE_ATTR_RO(status);
>  
> +static ssize_t
> +error_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
> +	int ret;
> +
> +	mutex_lock(&smgr->lock);
> +
> +	if (smgr->progress != FPGA_SEC_PROG_IDLE)
> +		ret = -EBUSY;
> +	else if (!smgr->err_code)
> +		ret = 0;
> +	else
> +		ret = sysfs_emit(buf, "%s:%s\n",
> +				 sec_progress(dev, smgr->err_state),
> +				 sec_error(dev, smgr->err_code));
> +
> +	mutex_unlock(&smgr->lock);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(error);
> +
>  static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -175,6 +233,7 @@ static DEVICE_ATTR_WO(filename);
>  static struct attribute *sec_mgr_update_attrs[] = {
>  	&dev_attr_filename.attr,
>  	&dev_attr_status.attr,
> +	&dev_attr_error.attr,
>  	NULL,
>  };
>  
> diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
> index 978ab98ffac5..6b7b8a3d6aac 100644
> --- a/include/linux/fpga/fpga-sec-mgr.h
> +++ b/include/linux/fpga/fpga-sec-mgr.h
> @@ -70,6 +70,7 @@ struct fpga_sec_mgr {
>  	const u8 *data;			/* pointer to update data */
>  	u32 remaining_size;		/* size remaining to transfer */
>  	enum fpga_sec_prog progress;
> +	enum fpga_sec_prog err_state;	/* progress state at time of failure */
>  	enum fpga_sec_err err_code;	/* security manager error code */
>  	bool driver_unload;
>  	void *priv;
> -- 
> 2.25.1
> 

Looks good,
Moritz
