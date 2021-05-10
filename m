Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF547379623
	for <lists+linux-fpga@lfdr.de>; Mon, 10 May 2021 19:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhEJRl1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 May 2021 13:41:27 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35431 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhEJRlZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 May 2021 13:41:25 -0400
Received: by mail-pl1-f171.google.com with SMTP id t21so9510929plo.2;
        Mon, 10 May 2021 10:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GoooP/PmUjS0wrSD+u1XGq0TKog5KneIwzKATPyJhNM=;
        b=LrHaJT/ySUwQiLVoudlLlvA4dGGO8MseZ/A4CQ6U5685qLJy+4jr6tTMXjE/fQAxDc
         00h4oM9R/hH59NH79Q104A1l1jAomV/aJttjgMemnou+mcuoZlr3rDhnbLbKMEYdQuOi
         ZQfAAQSFrsCt3j0Wv5glAgrqk3S27OJfV3S8cB8d4factmPCVE+ek4Z1dinlxWznHOXo
         s3NRRlpECK6kCfBUHtBtMYpTPtvPmvfCZyCiwER1Zdk5Bje8wOHxxqyvEWF4s8W84UJk
         JW+xM5Lctoe1mXQsosOOV7Hg7ZPgFQpxJudZMpbW0S80vbbexANLMDMt3tHpCQgCPrhQ
         k0Ag==
X-Gm-Message-State: AOAM533uEDJs2Mjsj4Suvegy812ofmM/Up8r1dvkPrmb8rmI87xGhE6l
        DMwCE46duCNq0qT5AP40AYs=
X-Google-Smtp-Source: ABdhPJzUhfqAiPsTeQvBXCUAjdp2kMqMorHenwJUUmPYHUAuJjQIhhJGm4Zs8njn1h0JY0PQb4zHwA==
X-Received: by 2002:a17:90a:6309:: with SMTP id e9mr341347pjj.20.1620668419927;
        Mon, 10 May 2021 10:40:19 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x62sm11630889pfb.71.2021.05.10.10.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:40:19 -0700 (PDT)
Date:   Mon, 10 May 2021 10:40:18 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v12 6/7] fpga: sec-mgr: enable cancel of secure update
Message-ID: <YJlwAixyDwTZkbhX@epycbox.lan>
References: <20210503213546.316439-1-russell.h.weight@intel.com>
 <20210503213546.316439-7-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503213546.316439-7-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 03, 2021 at 02:35:45PM -0700, Russ Weight wrote:
> Extend the FPGA Security Manager class driver to include
> an update/cancel sysfs file that can be written to request
> that an update be canceled. The write may return EBUSY if
> the update has progressed to the point that it cannot be
> canceled by software or ENODEV if there is no update in
> progress.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
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
>   - No change
> v4:
>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>     and removed unnecessary references to "Intel".
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> v3:
>   - No change
> v2:
>   - Bumped documentation date and version
>   - Minor code cleanup per review comments 
> ---
>  .../ABI/testing/sysfs-class-fpga-sec-mgr      | 10 ++++
>  drivers/fpga/fpga-sec-mgr.c                   | 59 +++++++++++++++++--
>  include/linux/fpga/fpga-sec-mgr.h             |  1 +
>  3 files changed, 66 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> index c5d0b9d7c7e4..749f2d4c78d3 100644
> --- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> @@ -17,6 +17,16 @@ Description:	Write only. Write the filename of an image
>  		and Root Entry Hashes, and to cancel Code Signing
>  		Keys (CSK).
>  
> +What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/cancel
> +Date:		June 2021
> +KernelVersion:	5.14
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Write-only. Write a "1" to this file to request
> +		that a current update be canceled. This request
> +		will be rejected (EBUSY) if the programming phase
> +		has already started or (ENODEV) if there is no
> +		update in progress.
> +
>  What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/status
>  Date:		June 2021
>  KernelVersion:	5.14
> diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
> index 2487042ace82..35bd419bd3b9 100644
> --- a/drivers/fpga/fpga-sec-mgr.c
> +++ b/drivers/fpga/fpga-sec-mgr.c
> @@ -43,6 +43,23 @@ static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
>  	smgr->sops->cancel(smgr);
>  }
>  
> +static int progress_transition(struct fpga_sec_mgr *smgr,
> +			       enum fpga_sec_prog new_progress)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&smgr->lock);
> +	if (smgr->request_cancel) {
> +		set_error(smgr, FPGA_SEC_ERR_CANCELED);
> +		smgr->sops->cancel(smgr);
> +		ret = -ECANCELED;
> +	} else {
> +		update_progress(smgr, new_progress);
> +	}
> +	mutex_unlock(&smgr->lock);
> +	return ret;
> +}
> +
>  static void progress_complete(struct fpga_sec_mgr *smgr)
>  {
>  	mutex_lock(&smgr->lock);
> @@ -74,15 +91,19 @@ static void fpga_sec_mgr_update(struct work_struct *work)
>  		goto release_fw_exit;
>  	}
>  
> -	update_progress(smgr, FPGA_SEC_PROG_PREPARING);
> +	if (progress_transition(smgr, FPGA_SEC_PROG_PREPARING))
> +		goto modput_exit;
> +
>  	ret = smgr->sops->prepare(smgr);
>  	if (ret != FPGA_SEC_ERR_NONE) {
>  		fpga_sec_dev_error(smgr, ret);
>  		goto modput_exit;
>  	}
>  
> -	update_progress(smgr, FPGA_SEC_PROG_WRITING);
> -	while (smgr->remaining_size) {
> +	if (progress_transition(smgr, FPGA_SEC_PROG_WRITING))
> +		goto done;
> +
> +	while (smgr->remaining_size && !smgr->request_cancel) {
>  		ret = smgr->sops->write_blk(smgr, offset);
>  		if (ret != FPGA_SEC_ERR_NONE) {
>  			fpga_sec_dev_error(smgr, ret);
> @@ -92,7 +113,9 @@ static void fpga_sec_mgr_update(struct work_struct *work)
>  		offset = fw->size - smgr->remaining_size;
>  	}
>  
> -	update_progress(smgr, FPGA_SEC_PROG_PROGRAMMING);
> +	if (progress_transition(smgr, FPGA_SEC_PROG_PROGRAMMING))
> +		goto done;
> +
>  	ret = smgr->sops->poll_complete(smgr);
>  	if (ret != FPGA_SEC_ERR_NONE)
>  		fpga_sec_dev_error(smgr, ret);
> @@ -229,6 +252,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  	}
>  
>  	smgr->err_code = FPGA_SEC_ERR_NONE;
> +	smgr->request_cancel = false;
>  	smgr->progress = FPGA_SEC_PROG_READING;
>  	reinit_completion(&smgr->update_done);
>  	schedule_work(&smgr->work);
> @@ -239,8 +263,32 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(filename);
>  
> +static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
> +	bool cancel;
> +	int ret = count;
> +
> +	if (kstrtobool(buf, &cancel) || !cancel)
> +		return -EINVAL;
> +
> +	mutex_lock(&smgr->lock);
> +	if (smgr->progress == FPGA_SEC_PROG_PROGRAMMING)
> +		ret = -EBUSY;
> +	else if (smgr->progress == FPGA_SEC_PROG_IDLE)
> +		ret = -ENODEV;
> +	else
> +		smgr->request_cancel = true;
> +	mutex_unlock(&smgr->lock);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_WO(cancel);
> +
>  static struct attribute *sec_mgr_update_attrs[] = {
>  	&dev_attr_filename.attr,
> +	&dev_attr_cancel.attr,
>  	&dev_attr_status.attr,
>  	&dev_attr_error.attr,
>  	&dev_attr_remaining_size.attr,
> @@ -464,6 +512,9 @@ void fpga_sec_mgr_unregister(struct fpga_sec_mgr *smgr)
>  		goto unregister;
>  	}
>  
> +	if (smgr->progress != FPGA_SEC_PROG_PROGRAMMING)
> +		smgr->request_cancel = true;
> +
>  	mutex_unlock(&smgr->lock);
>  	wait_for_completion(&smgr->update_done);
>  
> diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
> index 6b7b8a3d6aac..0e1f50434024 100644
> --- a/include/linux/fpga/fpga-sec-mgr.h
> +++ b/include/linux/fpga/fpga-sec-mgr.h
> @@ -72,6 +72,7 @@ struct fpga_sec_mgr {
>  	enum fpga_sec_prog progress;
>  	enum fpga_sec_prog err_state;	/* progress state at time of failure */
>  	enum fpga_sec_err err_code;	/* security manager error code */
> +	bool request_cancel;
>  	bool driver_unload;
>  	void *priv;
>  };
> -- 
> 2.25.1
> 

Looks good,
Moritz
