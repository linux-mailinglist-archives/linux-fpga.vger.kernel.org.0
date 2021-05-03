Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091D33715F1
	for <lists+linux-fpga@lfdr.de>; Mon,  3 May 2021 15:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhECN2N (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 3 May 2021 09:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234250AbhECN2L (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 3 May 2021 09:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620048437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QL45cC47deUfLwVC3MoPNpYWRQ8R9TGyabbyhDiCTsY=;
        b=UXrzLpYvmYVtKlXApfvfpKiUdoXgU4hBeEf8AB9W0rwx0X4jv5B7ZkSoPNBsPiIlaw7IfS
        B09n7+VrU7tNMCenDB0JRKBvzoES+A78SZG74U5XW6CRXKYAKd0/NAVPiUU4atN6MpSTzR
        Xmb0/dj1rABBHgnthGpwnrS01Vb7GeE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-sn98qkDJMpa6p3RjXqRWeg-1; Mon, 03 May 2021 09:27:15 -0400
X-MC-Unique: sn98qkDJMpa6p3RjXqRWeg-1
Received: by mail-qv1-f72.google.com with SMTP id f20-20020a0caa940000b02901c5058e5813so4181126qvb.23
        for <linux-fpga@vger.kernel.org>; Mon, 03 May 2021 06:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QL45cC47deUfLwVC3MoPNpYWRQ8R9TGyabbyhDiCTsY=;
        b=ByL/Y9zBkWCH40Eq/i8iWlU0Hv0mam9uxSAWBcsnzF82GVd/Bd/598kWLwToxYz7s0
         8CemXQlWPe6JLx7tYpoJ/bZpo02QiaHbWY1cKkmlIqBe32m0YsuUjo1nlkKrCp+VvQaM
         b9RcqfFjehzNODHKow0pVwglo0+tdZiEH+te9iRiJ9UMozkLfGvUXQAAYa8Sm7TE8zuJ
         1mAbUuEjX/g05L6o+6/YcwSY6HOnuggvGA8OsDcDLX6nVzPOoYakGPwhY22SjjP3MteN
         xE0dMIsEHj5DCfymveY7JExHhH+VLEsErPxk7rX+1DwVtIfIlehEzVcQaLfHeCBOf6+u
         EbjA==
X-Gm-Message-State: AOAM53309Wnin8AI+/gP5GLGoN6hvl1agiiSh5aJ0vyVWDahNm62Gv+b
        4QiWtu9eHkqFMPn5hAhrwc+Buc/pBeMrKZUACuJHOvVrSMwkf3KNj1ycXGx1l480Onl2EYnj4H5
        WpyNR7SIzKyqA34NcdaH2YA==
X-Received: by 2002:a0c:c447:: with SMTP id t7mr15873536qvi.60.1620048434986;
        Mon, 03 May 2021 06:27:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4KiYJDCGMSDAPav4l7m/bk3CIkorzrCaBbKKKKEyBYHlpD41oGhfDoWhjs7+DRNnrwGT+tg==
X-Received: by 2002:a0c:c447:: with SMTP id t7mr15873510qvi.60.1620048434764;
        Mon, 03 May 2021 06:27:14 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c23sm8715523qtm.46.2021.05.03.06.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 06:27:14 -0700 (PDT)
Subject: Re: [PATCH V5 XRT Alveo 06/20] fpga: xrt: char dev node helper
 functions
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
 <20210427205431.23896-7-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <5b4f95f0-9627-e584-13fb-338291d5c4e8@redhat.com>
Date:   Mon, 3 May 2021 06:27:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427205431.23896-7-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/27/21 1:54 PM, Lizhi Hou wrote:
> Helper functions for char device node creation / removal for xrt
> drivers. This is part of xrt driver infrastructure.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   drivers/fpga/xrt/lib/cdev.c | 210 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 210 insertions(+)
>   create mode 100644 drivers/fpga/xrt/lib/cdev.c
>
> diff --git a/drivers/fpga/xrt/lib/cdev.c b/drivers/fpga/xrt/lib/cdev.c
> new file mode 100644
> index 000000000000..4edd2c1d459b
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/cdev.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA device node helper functions.
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#include "xleaf.h"
> +
> +extern struct class *xrt_class;
> +
> +#define XRT_CDEV_DIR		"xrt"
ok
> +#define INODE2PDATA(inode)	\
> +	container_of((inode)->i_cdev, struct xrt_subdev_platdata, xsp_cdev)
> +#define INODE2PDEV(inode)	\
> +	to_xrt_dev(kobj_to_dev((inode)->i_cdev->kobj.parent))
> +#define CDEV_NAME(sysdev)	(strchr((sysdev)->kobj.name, '!') + 1)
> +
> +/* Allow it to be accessed from cdev. */
> +static void xleaf_devnode_allowed(struct xrt_device *xdev)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(xdev);
> +
> +	/* Allow new opens. */
> +	mutex_lock(&pdata->xsp_devnode_lock);
> +	pdata->xsp_devnode_online = true;
> +	mutex_unlock(&pdata->xsp_devnode_lock);
> +}
> +
> +/* Turn off access from cdev and wait for all existing user to go away. */
> +static void xleaf_devnode_disallowed(struct xrt_device *xdev)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(xdev);
> +
> +	mutex_lock(&pdata->xsp_devnode_lock);
> +
> +	/* Prevent new opens. */
> +	pdata->xsp_devnode_online = false;
> +	/* Wait for existing user to close. */
> +	while (pdata->xsp_devnode_ref) {
> +		mutex_unlock(&pdata->xsp_devnode_lock);
> +		wait_for_completion(&pdata->xsp_devnode_comp);
> +		mutex_lock(&pdata->xsp_devnode_lock);
> +	}
> +
> +	mutex_unlock(&pdata->xsp_devnode_lock);
> +}
> +
> +static struct xrt_device *
> +__xleaf_devnode_open(struct inode *inode, bool excl)
> +{
> +	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
> +	struct xrt_device *xdev = INODE2PDEV(inode);
> +	bool opened = false;
> +
> +	mutex_lock(&pdata->xsp_devnode_lock);
> +
> +	if (pdata->xsp_devnode_online) {
> +		if (excl && pdata->xsp_devnode_ref) {
> +			xrt_err(xdev, "%s has already been opened exclusively",
> +				CDEV_NAME(pdata->xsp_sysdev));
> +		} else if (!excl && pdata->xsp_devnode_excl) {
> +			xrt_err(xdev, "%s has been opened exclusively",
> +				CDEV_NAME(pdata->xsp_sysdev));
> +		} else {
> +			pdata->xsp_devnode_ref++;
> +			pdata->xsp_devnode_excl = excl;
> +			opened = true;
> +			xrt_info(xdev, "opened %s, ref=%d",
> +				 CDEV_NAME(pdata->xsp_sysdev),
> +				 pdata->xsp_devnode_ref);
> +		}
> +	} else {
> +		xrt_err(xdev, "%s is offline", CDEV_NAME(pdata->xsp_sysdev));
> +	}
> +
> +	mutex_unlock(&pdata->xsp_devnode_lock);
> +
> +	xdev = opened ? xdev : NULL;
> +	return xdev;
> +}
> +
> +struct xrt_device *
> +xleaf_devnode_open_excl(struct inode *inode)
> +{
> +	return __xleaf_devnode_open(inode, true);
ok
> +}
> +
> +struct xrt_device *
> +xleaf_devnode_open(struct inode *inode)
> +{
> +	return __xleaf_devnode_open(inode, false);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_devnode_open);
ok
> +
> +void xleaf_devnode_close(struct inode *inode)
> +{
> +	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
> +	struct xrt_device *xdev = INODE2PDEV(inode);
> +	bool notify = false;
> +
> +	mutex_lock(&pdata->xsp_devnode_lock);
> +
> +	WARN_ON(pdata->xsp_devnode_ref == 0);
> +	pdata->xsp_devnode_ref--;
> +	if (pdata->xsp_devnode_ref == 0) {
> +		pdata->xsp_devnode_excl = false;
> +		notify = true;
> +	}
> +	if (notify)
> +		xrt_info(xdev, "closed %s", CDEV_NAME(pdata->xsp_sysdev));
ok
> +	else
> +		xrt_info(xdev, "closed %s, notifying waiter", CDEV_NAME(pdata->xsp_sysdev));
> +
> +	mutex_unlock(&pdata->xsp_devnode_lock);
> +
> +	if (notify)
> +		complete(&pdata->xsp_devnode_comp);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_devnode_close);
> +
> +static inline enum xrt_dev_file_mode
> +devnode_mode(struct xrt_device *xdev)
> +{
> +	return DEV_FILE_OPS(xdev)->xsf_mode;
> +}
> +
> +int xleaf_devnode_create(struct xrt_device *xdev, const char *file_name,
> +			 const char *inst_name)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(xdev);
> +	struct xrt_dev_file_ops *fops = DEV_FILE_OPS(xdev);
> +	struct cdev *cdevp;
> +	struct device *sysdev;
> +	int ret = 0;
> +	char fname[256];
> +
> +	mutex_init(&pdata->xsp_devnode_lock);
> +	init_completion(&pdata->xsp_devnode_comp);
> +
> +	cdevp = &DEV_PDATA(xdev)->xsp_cdev;
> +	cdev_init(cdevp, &fops->xsf_ops);
> +	cdevp->owner = fops->xsf_ops.owner;
> +	cdevp->dev = MKDEV(MAJOR(fops->xsf_dev_t), xdev->instance);
> +
> +	/*
> +	 * Set xdev as parent of cdev so that when xdev (and its platform
> +	 * data) will not be freed when cdev is not freed.
> +	 */
> +	cdev_set_parent(cdevp, &DEV(xdev)->kobj);
> +
> +	ret = cdev_add(cdevp, cdevp->dev, 1);
> +	if (ret) {
> +		xrt_err(xdev, "failed to add cdev: %d", ret);
> +		goto failed;
> +	}
> +	if (!file_name)
> +		file_name = xdev->name;
> +	if (!inst_name) {
> +		if (devnode_mode(xdev) == XRT_DEV_FILE_MULTI_INST) {
> +			snprintf(fname, sizeof(fname), "%s/%s/%s.%u",
> +				 XRT_CDEV_DIR, DEV_PDATA(xdev)->xsp_root_name,
> +				 file_name, xdev->instance);
> +		} else {
> +			snprintf(fname, sizeof(fname), "%s/%s/%s",
> +				 XRT_CDEV_DIR, DEV_PDATA(xdev)->xsp_root_name,
> +				 file_name);
> +		}
> +	} else {
> +		snprintf(fname, sizeof(fname), "%s/%s/%s.%s", XRT_CDEV_DIR,
> +			 DEV_PDATA(xdev)->xsp_root_name, file_name, inst_name);
> +	}
> +	sysdev = device_create(xrt_class, NULL, cdevp->dev, NULL, "%s", fname);
> +	if (IS_ERR(sysdev)) {
> +		ret = PTR_ERR(sysdev);
> +		xrt_err(xdev, "failed to create device node: %d", ret);
> +		goto failed_cdev_add;
> +	}
> +	pdata->xsp_sysdev = sysdev;
> +
> +	xleaf_devnode_allowed(xdev);
> +
> +	xrt_info(xdev, "created (%d, %d): /dev/%s",
> +		 MAJOR(cdevp->dev), xdev->instance, fname);
> +	return 0;
> +
> +failed_cdev_add:
> +	cdev_del(cdevp);
> +failed:
> +	cdevp->owner = NULL;
> +	return ret;
> +}
> +
> +void xleaf_devnode_destroy(struct xrt_device *xdev)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(xdev);
> +	struct cdev *cdevp = &pdata->xsp_cdev;
> +	dev_t dev = cdevp->dev;
> +
> +	xleaf_devnode_disallowed(xdev);

ok

Reviewed-by: Tom Rix <trix@redhat.com>

> +
> +	xrt_info(xdev, "removed (%d, %d): /dev/%s/%s", MAJOR(dev), MINOR(dev),
> +		 XRT_CDEV_DIR, CDEV_NAME(pdata->xsp_sysdev));
> +	device_destroy(xrt_class, cdevp->dev);
> +	pdata->xsp_sysdev = NULL;
> +	cdev_del(cdevp);
> +}

