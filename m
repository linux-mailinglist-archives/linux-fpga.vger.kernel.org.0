Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F28A379621
	for <lists+linux-fpga@lfdr.de>; Mon, 10 May 2021 19:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhEJRks (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 May 2021 13:40:48 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:43617 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhEJRkr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 May 2021 13:40:47 -0400
Received: by mail-pl1-f177.google.com with SMTP id b15so3321285plh.10;
        Mon, 10 May 2021 10:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RiybN9lfXGi86KnTPptsLsDrVGdFlCjlxu/8MgdbxLc=;
        b=QhE1004lijZSdwxpLpzmc7E6E/b2VwM5+EqZkjg8QVFjpgl4mFVih5x5egWQ1N5mCx
         OkZ8pSOq7sibhSvmf2Q5lX3ViozZEFbL9R4B8XT+8zOHpWJGujXMudf5S1nXFa6peRrx
         pGMFbSk0IKxeY3yT0+vW/HXmET24LXWPzO89UNCLm2iKWidCKDmq4CgwnUYCuWOKXRsv
         K6ob5TyW/ihTK0irYwJoTgrzyLfPjJzgmKOznPu8mH6HooTwv+Z6i4YeXFI0zkvXquWn
         cx6gWiwjEJddLdhQQPjdTFDan8v/LhaisqpL/Xxws0rLCkW5TWkN8/ffpwTZ8yqsXLDQ
         iy6w==
X-Gm-Message-State: AOAM53127WyQROiSIyxcexRpzF//Jsg7VrXElApzoYGOAVs+9aWqJuRR
        prk9Pa4L7iT1qODJjpoPZeg=
X-Google-Smtp-Source: ABdhPJxIug1QVLdHmuQkm67W0S8RQhwcVUWO/RFZPtnHzCqtDkHIE+S5SZljN35OCQ06GHkaL+Yp4Q==
X-Received: by 2002:a17:902:9893:b029:ee:e8a8:688c with SMTP id s19-20020a1709029893b02900eee8a8688cmr25714323plp.84.1620668381731;
        Mon, 10 May 2021 10:39:41 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id n189sm10138176pfn.10.2021.05.10.10.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:39:41 -0700 (PDT)
Date:   Mon, 10 May 2021 10:39:40 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v12 5/7] fpga: sec-mgr: expose sec-mgr update size
Message-ID: <YJlv3DFvpOJYUUni@epycbox.lan>
References: <20210503213546.316439-1-russell.h.weight@intel.com>
 <20210503213546.316439-6-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503213546.316439-6-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 03, 2021 at 02:35:44PM -0700, Russ Weight wrote:
> Extend the FPGA Security Manager class driver to include
> an update/remaining_size sysfs node that can be read to
> determine how much data remains to be transferred to the
> secure update engine. This file can be used to monitor
> progress during the "writing" phase of an update.
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
>   - Use new function sysfs_emit() in the remaining_size_show() function
> v4:
>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>     and removed unnecessary references to "Intel".
>   - Changed: imgr -> smgr, ifpga_ to fpga_
> v3:
>   - No change
> v2:
>   - Bumped documentation date and version
> ---
>  Documentation/ABI/testing/sysfs-class-fpga-sec-mgr | 11 +++++++++++
>  drivers/fpga/fpga-sec-mgr.c                        | 10 ++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> index 24890d04521f..c5d0b9d7c7e4 100644
> --- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> @@ -28,6 +28,17 @@ Description:	Read-only. Returns a string describing the current
>  		as it will be signaled by sysfs_notify() on each
>  		state change.
>  
> +What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/remaining_size
> +Date:		June 2021
> +KernelVersion:	5.14
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. Returns the size of data that remains to
> +		be written to the secure update engine. The size
> +		value is initialized to the full size of the file
> +		image and the value is updated periodically during
> +		the "writing" phase of the update.
> +		Format: "%u".
> +
>  What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/error
>  Date:		June 2021
>  KernelVersion:	5.14
> diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
> index e43fa2797d27..2487042ace82 100644
> --- a/drivers/fpga/fpga-sec-mgr.c
> +++ b/drivers/fpga/fpga-sec-mgr.c
> @@ -198,6 +198,15 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(error);
>  
> +static ssize_t remaining_size_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
> +
> +	return sysfs_emit(buf, "%u\n", smgr->remaining_size);
> +}
> +static DEVICE_ATTR_RO(remaining_size);
> +
>  static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -234,6 +243,7 @@ static struct attribute *sec_mgr_update_attrs[] = {
>  	&dev_attr_filename.attr,
>  	&dev_attr_status.attr,
>  	&dev_attr_error.attr,
> +	&dev_attr_remaining_size.attr,
>  	NULL,
>  };
>  
> -- 
> 2.25.1
> 

Looks good,
Moritz
