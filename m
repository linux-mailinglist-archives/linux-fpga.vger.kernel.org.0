Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70E625EF09
	for <lists+linux-fpga@lfdr.de>; Sun,  6 Sep 2020 18:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgIFQQk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 6 Sep 2020 12:16:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50880 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726931AbgIFQQi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 6 Sep 2020 12:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599408996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPP5lg7k+pqpXO4LqmsOWDF2WRHtXNsleur3yoDeHCo=;
        b=F+U9h8Yk/mDIjNbKMaX1MuEUjKnPXka7m0pPi7rMAvOnZJUXkHB66eXRZwFZGFc4rkIq8C
        9amFM4xB/JxNOI4URyTwkdSZLKRLAfDHIX7d+45dGERiqRKyQujoqdXT/iuEin+KrVQcU8
        B3maD548QZGbkZqofIt0Aa85UtC+Rgk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-7kGxe4oIP3iM9BYXQo5AOQ-1; Sun, 06 Sep 2020 12:16:34 -0400
X-MC-Unique: 7kGxe4oIP3iM9BYXQo5AOQ-1
Received: by mail-qt1-f197.google.com with SMTP id a14so7615488qtp.15
        for <linux-fpga@vger.kernel.org>; Sun, 06 Sep 2020 09:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hPP5lg7k+pqpXO4LqmsOWDF2WRHtXNsleur3yoDeHCo=;
        b=ijUXi1NBPr5wD/OYumXvb7CVMxT5TS049JZZNE37TuYgh+eSRfWsakRT3zQpJWjlrc
         knt3e6d6DREXvppU3HOmSIQ/jNonWef9boNZ0s4ZtCwysq2td8zME0RVNHEQ/91BndEy
         sgPkc/3udiamdgo6UTQbn0OYY1Au2Op8Zwry46O7ZNahVxcrLqrYH6LDjFGsV3ctp0N+
         PSHgYx3/oEfw5k+JjOxdw6+ECuuJfm6EKD0NvScweMSBgKNrpS5q1+Dhmlx3D05yurwy
         7YEG1sTnxPq4d2Rr5GubzUMD4m/WtrAwy6zFqGTwAVLxtVHf1qszVVThDY5ZCnpsDQfQ
         7TJA==
X-Gm-Message-State: AOAM530Uj1Wn6jLoBf4Gx2OD1ZDWgJEXzl2ZiYFv4KAqGfgHG4CkRfJn
        R2ABAs55Icm2CdR+2chyVd5D0tw66SNC15KLJKVZtAyyOLmQWVM8fMOjTYjZll1uu5fVZevGThq
        WhBA1ROyQ30BA7sz+xs4lhQ==
X-Received: by 2002:ac8:7650:: with SMTP id i16mr17566627qtr.268.1599408994033;
        Sun, 06 Sep 2020 09:16:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcYEz2ZgzUM/FAXVJ/NnpekBCMRXU+GZiYruI2Jb5lbYH2yTiwBoVy83dBUJxicfns8viOIg==
X-Received: by 2002:ac8:7650:: with SMTP id i16mr17566606qtr.268.1599408993770;
        Sun, 06 Sep 2020 09:16:33 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d10sm8939186qkk.1.2020.09.06.09.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 09:16:33 -0700 (PDT)
Subject: Re: [PATCH v1 07/12] fpga: expose sec-mgr update status
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-8-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4fdb6000-ced9-1713-cace-8e7b09c6d586@redhat.com>
Date:   Sun, 6 Sep 2020 09:16:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-8-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/4/20 4:53 PM, Russ Weight wrote:
> Extend the Intel Security Manager class driver to
> include an update/status sysfs node that can be polled
> and read to monitor the progress of an ongoing secure
> update. Sysfs_notify() is used to signal transitions
> between different phases of the update process.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 11 ++++++
>  drivers/fpga/ifpga-sec-mgr.c                  | 34 ++++++++++++++++---
>  2 files changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> index a476504b7ae9..849ccb2802f8 100644
> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -86,3 +86,14 @@ Description:	Write only. Write the filename of an Intel image
>  		BMC images, BMC firmware, Static Region images,
>  		and Root Entry Hashes, and to cancel Code Signing
>  		Keys (CSK).
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/status
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. Returns a string describing the current
> +		status of an update. The string will be one of the
> +		following: idle, read_file, preparing, writing,
For consistency, read_file -> reading
> +		programming. Userspace code can poll on this file,
> +		as it will be signaled by sysfs_notify() on each
> +		state change.
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> index 73173badbe96..5fe3d85e2963 100644
> --- a/drivers/fpga/ifpga-sec-mgr.c
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -139,6 +139,13 @@ static struct attribute *sec_mgr_security_attrs[] = {
>  	NULL,
>  };
>  
> +static void update_progress(struct ifpga_sec_mgr *imgr,
> +			    enum ifpga_sec_prog new_progress)
> +{
> +	imgr->progress = new_progress;
> +	sysfs_notify(&imgr->dev.kobj, "update", "status");
> +}
> +
>  static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>  				enum ifpga_sec_err err_code)
>  {
> @@ -149,7 +156,7 @@ static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>  static void progress_complete(struct ifpga_sec_mgr *imgr)
>  {
>  	mutex_lock(&imgr->lock);
> -	imgr->progress = IFPGA_SEC_PROG_IDLE;
> +	update_progress(imgr, IFPGA_SEC_PROG_IDLE);
>  	complete_all(&imgr->update_done);
>  	mutex_unlock(&imgr->lock);
>  }
> @@ -177,14 +184,14 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
>  		goto release_fw_exit;
>  	}
>  
> -	imgr->progress = IFPGA_SEC_PROG_PREPARING;
> +	update_progress(imgr, IFPGA_SEC_PROG_PREPARING);
>  	ret = imgr->iops->prepare(imgr);
>  	if (ret) {
>  		ifpga_sec_dev_error(imgr, ret);
>  		goto modput_exit;
>  	}
>  
> -	imgr->progress = IFPGA_SEC_PROG_WRITING;
> +	update_progress(imgr, IFPGA_SEC_PROG_WRITING);
>  	size = imgr->remaining_size;
>  	while (size) {
>  		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
> @@ -199,7 +206,7 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
>  		offset += blk_size;
>  	}
>  
> -	imgr->progress = IFPGA_SEC_PROG_PROGRAMMING;
> +	update_progress(imgr, IFPGA_SEC_PROG_PROGRAMMING);
>  	ret = imgr->iops->poll_complete(imgr);
>  	if (ret) {
>  		ifpga_sec_dev_error(imgr, ret);
> @@ -251,6 +258,24 @@ static struct attribute_group sec_mgr_security_attr_group = {
>  	.is_visible = sec_mgr_visible,
>  };
>  
> +static const char * const sec_mgr_prog_str[] = {
> +	"idle",			/* IFPGA_SEC_PROG_IDLE */
> +	"read_file",		/* IFPGA_SEC_PROG_READ_FILE */
"reading"
> +	"preparing",		/* IFPGA_SEC_PROG_PREPARING */
> +	"writing",		/* IFPGA_SEC_PROG_WRITING */
> +	"programming"		/* IFPGA_SEC_PROG_PROGRAMMING */
> +};
> +
> +static ssize_t
> +status_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
> +
> +	return sprintf(buf, "%s\n", (imgr->progress < IFPGA_SEC_PROG_MAX) ?
> +		       sec_mgr_prog_str[imgr->progress] : "unknown-status");

when imgr->progress is unknown, should there be a dev_warn ?

Tom

> +}
> +static DEVICE_ATTR_RO(status);
> +
>  static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -288,6 +313,7 @@ static DEVICE_ATTR_WO(filename);
>  
>  static struct attribute *sec_mgr_update_attrs[] = {
>  	&dev_attr_filename.attr,
> +	&dev_attr_status.attr,
>  	NULL,
>  };
>  

