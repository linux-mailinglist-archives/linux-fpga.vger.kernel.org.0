Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58D425EF34
	for <lists+linux-fpga@lfdr.de>; Sun,  6 Sep 2020 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIFRAa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 6 Sep 2020 13:00:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32592 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726209AbgIFRA3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 6 Sep 2020 13:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599411626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KdI8IleEpLudt0BXJdN8B3kDiZKjwrvJqnX9ZfyN8xM=;
        b=SyKIjvydsJhByx9hAmI2LbtJY7GtXSPySltproPAC73ro6LVwqTioHWu14e4D/CqmJQlY7
        +xpTNCIZROTJDus4nqDJV43jcGz6tIZq6TCLd/TbpysHjFMYrz6q4ThlqYaWm32Udy8Lh6
        hKYAT/Kqim7TyI3OTBe+b9YSd6xPA/0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-pJKHcKjHOwC0y62vN_wAhw-1; Sun, 06 Sep 2020 13:00:24 -0400
X-MC-Unique: pJKHcKjHOwC0y62vN_wAhw-1
Received: by mail-qt1-f197.google.com with SMTP id g1so7639912qtc.22
        for <linux-fpga@vger.kernel.org>; Sun, 06 Sep 2020 10:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KdI8IleEpLudt0BXJdN8B3kDiZKjwrvJqnX9ZfyN8xM=;
        b=ZSc24Gc+1hhrFYz7WFZAabd5ulJyu0vsCNdlyRTstp0vxM8Dozhl0j0DzWuik5qT9r
         nGSH0bp0EZMYNxFIHbLUpeKSabPUz4jflqlGbVM40DTUvm/dX867JBpQn4RHMV4Hxg0G
         DBO1TLYDUvhe0Du6sqMeNYetzN+A2boNbvI4ASkD4zGuxSjHhnvvQU7sgh7WJzUQffGS
         Z0PW4HgMF+QnvpRgsD2HbDEVSD6+f9yRlk78chOxM2w0buzwh3qBjkzpMXL5ya5G4PXC
         Pqe1JP1qDHPKD0yd0nYM4MD2g/baO8Gt9UMBEtC9wWpDH5IO0697fNCUf3IN/L6XPeyU
         N5zA==
X-Gm-Message-State: AOAM531eoOEvR1ACGWCs2tDv55j6N9UFoqJiDMXqnP/h0/C+wL7Bp8EP
        tRv7qYdM3zmfk9zC7UjobVv4wIDviGUGk/K5sCpEWHV6czOfCulpvSkMHAnP2Cj6qnpC2zrlWfo
        J6+wRThYGrK4yOzr4F7nsPA==
X-Received: by 2002:a0c:a481:: with SMTP id x1mr15446325qvx.6.1599411624082;
        Sun, 06 Sep 2020 10:00:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwkOriGunXBiwvWu1ncCEfhwh1rXabUcaeEvsIB5qmckXZsvJVZuj1TK/Rm93vXnVmB7KuGQ==
X-Received: by 2002:a0c:a481:: with SMTP id x1mr15446300qvx.6.1599411623744;
        Sun, 06 Sep 2020 10:00:23 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s18sm9071961qks.44.2020.09.06.10.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 10:00:23 -0700 (PDT)
Subject: Re: [PATCH v1 10/12] fpga: enable sec-mgr update cancel
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-11-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <bfcdc249-1cc7-e755-1030-cf1fed2416fa@redhat.com>
Date:   Sun, 6 Sep 2020 10:00:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-11-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/4/20 4:53 PM, Russ Weight wrote:
> Extend the Intel Security Manager class driver to include
> an update/cancel sysfs file that can be written to request
> that an update be canceled. The write may return EBUSY if
> the update has progressed to the point that it cannot be
> canceled by software or ENODEV if there is no update in
> progress.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 10 ++++
>  drivers/fpga/ifpga-sec-mgr.c                  | 59 +++++++++++++++++--
>  include/linux/fpga/ifpga-sec-mgr.h            |  1 +
>  3 files changed, 66 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> index cf1967f1b3e3..762a7dee9453 100644
> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -87,6 +87,16 @@ Description:	Write only. Write the filename of an Intel image
>  		and Root Entry Hashes, and to cancel Code Signing
>  		Keys (CSK).
>  
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/cancel
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Write-only. Write a "1" to this file to request
> +		that a current update be canceled. This request
> +		will be rejected (EBUSY) if the programming phase
> +		has already started or (ENODEV) if there is no
> +		update in progress.
> +
>  What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/status
>  Date:		Sep 2020
>  KernelVersion:  5.10
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> index 4ca5d13e5656..afd97c135ebe 100644
> --- a/drivers/fpga/ifpga-sec-mgr.c
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -159,6 +159,23 @@ static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>  	imgr->iops->cancel(imgr);
>  }
>  
> +static int progress_transition(struct ifpga_sec_mgr *imgr,
> +			       enum ifpga_sec_prog new_progress)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&imgr->lock);
> +	if (imgr->request_cancel) {
> +		set_error(imgr, IFPGA_SEC_ERR_CANCELED);
> +		imgr->iops->cancel(imgr);

check cancel() for double error ?

should request_cancel be cleared ?

> +		ret = -ECANCELED;
> +	} else {
> +		update_progress(imgr, new_progress);
> +	}
> +	mutex_unlock(&imgr->lock);
> +	return ret;
> +}
> +
>  static void progress_complete(struct ifpga_sec_mgr *imgr)
>  {
>  	mutex_lock(&imgr->lock);
> @@ -190,16 +207,20 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
>  		goto release_fw_exit;
>  	}
>  
> -	update_progress(imgr, IFPGA_SEC_PROG_PREPARING);
> +	if (progress_transition(imgr, IFPGA_SEC_PROG_PREPARING))
> +		goto modput_exit;
> +
>  	ret = imgr->iops->prepare(imgr);
>  	if (ret) {
>  		ifpga_sec_dev_error(imgr, ret);
>  		goto modput_exit;
>  	}
>  
> -	update_progress(imgr, IFPGA_SEC_PROG_WRITING);
> +	if (progress_transition(imgr, IFPGA_SEC_PROG_WRITING))
> +		goto done;
> +
>  	size = imgr->remaining_size;
> -	while (size) {
> +	while (size && !imgr->request_cancel) {
>  		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
>  		size -= blk_size;
>  		ret = imgr->iops->write_blk(imgr, offset, blk_size);
> @@ -212,7 +233,9 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
>  		offset += blk_size;
>  	}
>  
> -	update_progress(imgr, IFPGA_SEC_PROG_PROGRAMMING);
> +	if (progress_transition(imgr, IFPGA_SEC_PROG_PROGRAMMING))
> +		goto done;
> +
>  	ret = imgr->iops->poll_complete(imgr);
>  	if (ret) {
>  		ifpga_sec_dev_error(imgr, ret);
> @@ -359,6 +382,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  		imgr->filename[strlen(imgr->filename) - 1] = '\0';
>  
>  	imgr->err_code = IFPGA_SEC_ERR_NONE;
> +	imgr->request_cancel = false;
>  	imgr->progress = IFPGA_SEC_PROG_READ_FILE;
>  	reinit_completion(&imgr->update_done);
>  	schedule_work(&imgr->work);
> @@ -369,8 +393,32 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(filename);
>  
> +static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
> +	bool cancel;
> +	int ret = 0;
int ret = count;
> +
> +	if (kstrtobool(buf, &cancel) || !cancel)

This does not match your description in the testing section.

kstrtobool has many other valid inputs.

maybe check if count is 1 and buf[0] == '1'

> +		return -EINVAL;
> +
> +	mutex_lock(&imgr->lock);
> +	if (imgr->progress == IFPGA_SEC_PROG_PROGRAMMING)
> +		ret = -EBUSY;
> +	else if (imgr->progress == IFPGA_SEC_PROG_IDLE)
> +		ret = -ENODEV;
> +	else
> +		imgr->request_cancel = true;
> +	mutex_unlock(&imgr->lock);
> +
> +	return ret ? : count;

return ret;

Tom

> +}
> +static DEVICE_ATTR_WO(cancel);
> +
>  static struct attribute *sec_mgr_update_attrs[] = {
>  	&dev_attr_filename.attr,
> +	&dev_attr_cancel.attr,
>  	&dev_attr_status.attr,
>  	&dev_attr_error.attr,
>  	&dev_attr_remaining_size.attr,
> @@ -536,6 +584,9 @@ void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr)
>  		goto unregister;
>  	}
>  
> +	if (imgr->progress != IFPGA_SEC_PROG_PROGRAMMING)
> +		imgr->request_cancel = true;
> +
>  	mutex_unlock(&imgr->lock);
>  	wait_for_completion(&imgr->update_done);
>  
> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
> index f04bf9e30c67..f51ed663a723 100644
> --- a/include/linux/fpga/ifpga-sec-mgr.h
> +++ b/include/linux/fpga/ifpga-sec-mgr.h
> @@ -183,6 +183,7 @@ struct ifpga_sec_mgr {
>  	enum ifpga_sec_prog progress;
>  	enum ifpga_sec_prog err_state;	/* progress state at time of failure */
>  	enum ifpga_sec_err err_code;	/* security manager error code */
> +	bool request_cancel;
>  	bool driver_unload;
>  	void *priv;
>  };

