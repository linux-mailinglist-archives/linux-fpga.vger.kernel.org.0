Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF58925EF1E
	for <lists+linux-fpga@lfdr.de>; Sun,  6 Sep 2020 18:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgIFQ1s (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 6 Sep 2020 12:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbgIFQ1m (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 6 Sep 2020 12:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599409659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/C06vN/7MdL7V6faI+nEwBSMhsLrL04PKHUg25uFYY=;
        b=PiPk/yvzFp9r/KpLKkE/NWqtXsRL7djqOlbROyoB5AN9S+9b89+LXn1YE0P7PQyKX7USzE
        YxI/b8UiRbTcExfkzgDcPM9iDw/F4zwTC27VHHHkueANgcrlEPOruz10gZOXjShlk8k8VW
        /sp7svHMDiHpl7Tz0+WzHEEBsKWmAcQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-_9JD7w-5Nr-OTk1AO6zMzA-1; Sun, 06 Sep 2020 12:27:37 -0400
X-MC-Unique: _9JD7w-5Nr-OTk1AO6zMzA-1
Received: by mail-qk1-f200.google.com with SMTP id v16so6402776qka.18
        for <linux-fpga@vger.kernel.org>; Sun, 06 Sep 2020 09:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L/C06vN/7MdL7V6faI+nEwBSMhsLrL04PKHUg25uFYY=;
        b=F0964tzp0L2IlMRlg7DrtHcpgsOrB5CjdMfpL5Ki0eM1slR3jD9K+s0Yx0pADCZ931
         umCieAzvmPqhNscXU2WmG0JE1s6XbdiJGzzuYei788pLkaZykltYgZnYoRwRisJcR3Ss
         Hzo7AhJBgdJ24YWflUScGF5IBi+sWvIUH7EBuIdgRnq0uVNTRugvbLeb9qyBMtzWftZc
         /WrSsQNaSbPIe6t1LIqhWrIjfKMHBx/a99KABFLW5fc1MqCwSgxIz+4nTSMpzXxHcRtP
         newgy2ZoL7H/+seKaJeqekorhxiSLwvvgGIfJcf5zRjWcvY28RHTlReeVGqfU41xQmtS
         vOjQ==
X-Gm-Message-State: AOAM532OnIPovODi2dtUrdvTfj9Tw2qKnIYNntK6XXxyxpTJ8gXwnLLn
        ZixNsVuzx0OAryvPvdTq4b9s+C/WDSYy1RtHC0iTu2cXoSIAR+QsvOPi+l3mec9C1CUwDYtpTa/
        dWnBTjevFqPF4zZe+M/F+fw==
X-Received: by 2002:ac8:7a96:: with SMTP id x22mr17919745qtr.245.1599409657450;
        Sun, 06 Sep 2020 09:27:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFYDs1QtqFhBfmoXzKDts649/pd2vCUnJC1cr9JJrNLNmH7yrCUIWUyalUKdLurkgc81VJrQ==
X-Received: by 2002:ac8:7a96:: with SMTP id x22mr17919728qtr.245.1599409657176;
        Sun, 06 Sep 2020 09:27:37 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z17sm3511726qti.38.2020.09.06.09.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 09:27:36 -0700 (PDT)
Subject: Re: [PATCH v1 08/12] fpga: expose sec-mgr update errors
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-9-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <448b27a2-0724-77c1-20e8-1c3ff9287034@redhat.com>
Date:   Sun, 6 Sep 2020 09:27:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-9-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/4/20 4:53 PM, Russ Weight wrote:
> Extend Intel Security Manager class driver to include
> an update/error sysfs node that can be read for error
> information when a secure update fails.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 17 ++++++
>  drivers/fpga/ifpga-sec-mgr.c                  | 60 +++++++++++++++++--
>  include/linux/fpga/ifpga-sec-mgr.h            |  1 +
>  3 files changed, 73 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> index 849ccb2802f8..e7b1b02bf7ee 100644
> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -97,3 +97,20 @@ Description:	Read-only. Returns a string describing the current
>  		programming. Userspace code can poll on this file,
>  		as it will be signaled by sysfs_notify() on each
>  		state change.
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/error
> +Date:		Sep 2020
> +KernelVersion:  5.10
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
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> index 5fe3d85e2963..a7718bd8ee61 100644
> --- a/drivers/fpga/ifpga-sec-mgr.c
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -146,10 +146,16 @@ static void update_progress(struct ifpga_sec_mgr *imgr,
>  	sysfs_notify(&imgr->dev.kobj, "update", "status");
>  }
>  
> +static void set_error(struct ifpga_sec_mgr *imgr, enum ifpga_sec_err err_code)
> +{
> +	imgr->err_state = imgr->progress;
> +	imgr->err_code = err_code;
> +}
> +
>  static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>  				enum ifpga_sec_err err_code)
>  {
> -	imgr->err_code = err_code;
> +	set_error(imgr, err_code);
>  	imgr->iops->cancel(imgr);
>  }
>  
> @@ -172,7 +178,7 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
>  
>  	get_device(&imgr->dev);
>  	if (request_firmware(&fw, imgr->filename, &imgr->dev)) {
> -		imgr->err_code = IFPGA_SEC_ERR_FILE_READ;
> +		set_error(imgr, IFPGA_SEC_ERR_FILE_READ);
>  		goto idle_exit;
>  	}
>  
> @@ -180,7 +186,7 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
>  	imgr->remaining_size = fw->size;
>  
>  	if (!try_module_get(imgr->dev.parent->driver->owner)) {
> -		imgr->err_code = IFPGA_SEC_ERR_BUSY;
> +		set_error(imgr, IFPGA_SEC_ERR_BUSY);
>  		goto release_fw_exit;
>  	}
>  
> @@ -266,16 +272,59 @@ static const char * const sec_mgr_prog_str[] = {
>  	"programming"		/* IFPGA_SEC_PROG_PROGRAMMING */
>  };
>  
> +static const char * const sec_mgr_err_str[] = {
> +	"none",			/* IFPGA_SEC_ERR_NONE */
> +	"hw-error",		/* IFPGA_SEC_ERR_HW_ERROR */
> +	"timeout",		/* IFPGA_SEC_ERR_TIMEOUT */
> +	"user-abort",		/* IFPGA_SEC_ERR_CANCELED */
> +	"device-busy",		/* IFPGA_SEC_ERR_BUSY */
> +	"invalid-file-size",	/* IFPGA_SEC_ERR_INVALID_SIZE */
> +	"read-write-error",	/* IFPGA_SEC_ERR_RW_ERROR */
> +	"flash-wearout",	/* IFPGA_SEC_ERR_WEAROUT */
> +	"file-read-error"	/* IFPGA_SEC_ERR_FILE_READ */
> +};
> +
> +static const char *sec_progress(enum ifpga_sec_prog prog)
> +{
A consistent api would have imgr as the parameter.
> +	return (prog < IFPGA_SEC_PROG_MAX) ?
> +		sec_mgr_prog_str[prog] : "unknown-status";
> +}
> +
>  static ssize_t
>  status_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>  
> -	return sprintf(buf, "%s\n", (imgr->progress < IFPGA_SEC_PROG_MAX) ?
> -		       sec_mgr_prog_str[imgr->progress] : "unknown-status");
> +	return sprintf(buf, "%s\n", sec_progress(imgr->progress));
>  }
>  static DEVICE_ATTR_RO(status);
>  
> +static ssize_t
> +error_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
> +	enum ifpga_sec_err err_code;
> +	const char *prog_str;
> +	int ret;
> +
> +	mutex_lock(&imgr->lock);
> +	if (imgr->progress != IFPGA_SEC_PROG_IDLE) {
> +		ret = -EBUSY;
> +	} else if (!imgr->err_code) {
> +		ret = 0;
> +	} else {
> +		err_code = imgr->err_code;
> +		prog_str = sec_progress(imgr->err_state);
> +		ret = sprintf(buf, "%s:%s\n", prog_str,
> +			      (err_code < IFPGA_SEC_ERR_MAX) ?
> +			      sec_mgr_err_str[err_code] : "unknown-error");

Should have sec_error() call to match the new sec_progress()

Tom

> +	}
> +	mutex_unlock(&imgr->lock);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(error);
> +
>  static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -314,6 +363,7 @@ static DEVICE_ATTR_WO(filename);
>  static struct attribute *sec_mgr_update_attrs[] = {
>  	&dev_attr_filename.attr,
>  	&dev_attr_status.attr,
> +	&dev_attr_error.attr,
>  	NULL,
>  };
>  
> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
> index 4da2864e251c..f04bf9e30c67 100644
> --- a/include/linux/fpga/ifpga-sec-mgr.h
> +++ b/include/linux/fpga/ifpga-sec-mgr.h
> @@ -181,6 +181,7 @@ struct ifpga_sec_mgr {
>  	const u8 *data;			/* pointer to update data */
>  	u32 remaining_size;		/* size remaining to transfer */
>  	enum ifpga_sec_prog progress;
> +	enum ifpga_sec_prog err_state;	/* progress state at time of failure */
>  	enum ifpga_sec_err err_code;	/* security manager error code */
>  	bool driver_unload;
>  	void *priv;

