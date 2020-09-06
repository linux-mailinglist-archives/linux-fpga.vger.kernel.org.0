Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DD025EF28
	for <lists+linux-fpga@lfdr.de>; Sun,  6 Sep 2020 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgIFQjS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 6 Sep 2020 12:39:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32746 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725816AbgIFQjQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 6 Sep 2020 12:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599410354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OX3Xc/v5tqk5R7fQDohwMLEotWZXIlqF2f90wFzok8=;
        b=LgutfSMzJyPYJkSuJ96EPvq2LexcXQVHwdNvB2DTtq1tTH1XQSTrwrzMAsRG7Ygsc1v5a0
        W8/k8qclJsvQnhK3X2T/d7kHaXy7EZbkMG9kp0KdlC9wa3KtY1yuraXp8XxRY3qCPPDh9M
        8RBVHs5wiWGk0Jcg3ZJHTIx8HL4wljg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-ak4JYU36MXu4_HGWQ7yCPw-1; Sun, 06 Sep 2020 12:39:13 -0400
X-MC-Unique: ak4JYU36MXu4_HGWQ7yCPw-1
Received: by mail-qk1-f197.google.com with SMTP id z190so6475264qkc.5
        for <linux-fpga@vger.kernel.org>; Sun, 06 Sep 2020 09:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4OX3Xc/v5tqk5R7fQDohwMLEotWZXIlqF2f90wFzok8=;
        b=sG897EL4wQ2oM+scmv67lTppiRHFN3OFMakSnBFvvtZBR5ouIaCOmoxPZS2KTDYgCv
         JURunFPCNoZ7K3bTjagSa9tLoZ9XfRzZo7CWt2UF3utR2C6aC7A30jkPuUyRBL6FqSEX
         SLfetAa4ES4KLPYE9LUJ+y9Id0FoymgFLLQTyWlh2KxhCmeWeoDUgD2m95krZDie7WXZ
         fkX7+x4c0ORSUdCmUklk+Rk9MPksk99N2llqcc9M6Fklp4UycMRnMVCfMaZ7R1ZuBg3h
         x38hz0RtDwp+S+C5oihnEAX6kfTRgXOE9OApG2igUfg4AykrdGo+wMoXNpPE8pHDpWvH
         Vbvw==
X-Gm-Message-State: AOAM531GJhNg+G1w7fi91x5w5FfwIgHijDjjc2AcbKpWThhvuVNFTr7a
        tFoKzj7EC+vKkPbJjVpf1s+ah51c1uJceR58ioaE/teGZ+vN2K9c0F69ZiezMUwy7aa3CXUgNlB
        57UoR5ir6hSEkZ1mA6nKOLg==
X-Received: by 2002:ac8:12c1:: with SMTP id b1mr17880964qtj.148.1599410352723;
        Sun, 06 Sep 2020 09:39:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBTjz40kE7kH1ObZ2Pej4m3hzM4p5WVMaw+MYN4tu+a8LcxfIaVB94ri8o+oZypOdb+KtYpg==
X-Received: by 2002:ac8:12c1:: with SMTP id b1mr17880953qtj.148.1599410352451;
        Sun, 06 Sep 2020 09:39:12 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s20sm9041012qkg.65.2020.09.06.09.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 09:39:11 -0700 (PDT)
Subject: Re: [PATCH v1 09/12] fpga: expose sec-mgr update size
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-10-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f9212bb3-c624-06e3-383b-9bb56717f795@redhat.com>
Date:   Sun, 6 Sep 2020 09:39:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-10-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/4/20 4:53 PM, Russ Weight wrote:
> Extend the Intel Security Manager class driver to include
> an update/remaining_size sysfs node that can be read to
> determine how much data remains to be transferred to the
> secure update engine. This file can be used to monitor
> progress during the "writing" phase of an update.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr | 11 +++++++++++
>  drivers/fpga/ifpga-sec-mgr.c                        | 10 ++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> index e7b1b02bf7ee..cf1967f1b3e3 100644
> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -98,6 +98,17 @@ Description:	Read-only. Returns a string describing the current
>  		as it will be signaled by sysfs_notify() on each
>  		state change.
>  
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/remaining_size
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. Returns the size of data that remains to
> +		be written to the secure update engine. The size
> +		value is initialized to the full size of the file
> +		image and the value is updated periodically during
> +		the "writing" phase of the update.
> +		Format: "%u".
> +
>  What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/error
>  Date:		Sep 2020
>  KernelVersion:  5.10
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> index a7718bd8ee61..4ca5d13e5656 100644
> --- a/drivers/fpga/ifpga-sec-mgr.c
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -325,6 +325,15 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(error);
>  
> +static ssize_t remaining_size_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
> +
> +	return sprintf(buf, "%u\n", imgr->remaining_size);
> +}
> +static DEVICE_ATTR_RO(remaining_size);
> +
>  static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -364,6 +373,7 @@ static struct attribute *sec_mgr_update_attrs[] = {
>  	&dev_attr_filename.attr,
>  	&dev_attr_status.attr,
>  	&dev_attr_error.attr,
> +	&dev_attr_remaining_size.attr,
>  	NULL,
>  };
>  

Looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

