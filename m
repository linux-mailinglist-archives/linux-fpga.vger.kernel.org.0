Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0634E97F
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Mar 2021 15:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhC3Npn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Mar 2021 09:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231910AbhC3NpU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 30 Mar 2021 09:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617111919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TvixdV6Zx7/AWSYPQxJ6x7+mxKn8oXSTnyruFM7nqLc=;
        b=YaGMSWf9pVcvyzfksGM9cdS9kaWcExgSeFYuKcmcAjZIL6SZmfcyhcccZkcd+jCcQl1tAx
        +jG6fL2c3ATKzNB5wnKQX7Pp9G0bTwot72tNCvAUrU3+lQxml2BppS60l5HXwq6PkC6480
        qdriq/V2HV7frv79dwzl748pS2jWXrE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-ETxDzAUmM8is66jkFj5dEw-1; Tue, 30 Mar 2021 09:45:14 -0400
X-MC-Unique: ETxDzAUmM8is66jkFj5dEw-1
Received: by mail-qt1-f199.google.com with SMTP id t18so9699699qtw.15
        for <linux-fpga@vger.kernel.org>; Tue, 30 Mar 2021 06:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TvixdV6Zx7/AWSYPQxJ6x7+mxKn8oXSTnyruFM7nqLc=;
        b=Rvi3N2PEy/mdGzkqjTjWU2zp0FtXmM6s0bHbF3iELOjtrvpoynkVbLT+tX7kQmhT4P
         0H1Fwkn98QSONn3yIGQqM8AoU12ZFiHDlswqDtdGVEl5yKIrVGta3Eeoym6BJL02YaUM
         MxM0x4G61iNr3f8sbA+JzpFtq4+ZDWK9pkW4I1Ct1Q90eiNzBOEHDTIYmftv0MQLrc6R
         BHdzdCitshbZYNfhG4biusph3ZDXYCCkNolC69ibqjIZrEubZHRlaqOUl/eE6PkvuymO
         SHh5E4sPNQ/xxGu7/VvTz2vH8SY8JZVZMQeYwhmRCIiqYtk7fBUN9YM2bF93zINssyEz
         /Dzg==
X-Gm-Message-State: AOAM532bRTjVheYu+kYmFsLj/0lFShTVegu0aRpLRnyi4wo7s/h0BxPJ
        lagKbDcgZDltaJS9ro7TvvG7fdEXpKgeiRradhoBUlxRentYDbjokBDWPudUCvMsc6UwU5yfSo+
        iZklqEd5XgPblnHNhxqwXrw==
X-Received: by 2002:a05:6214:21a5:: with SMTP id t5mr30882338qvc.23.1617111914304;
        Tue, 30 Mar 2021 06:45:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWta3aXZ38aPclAoYDQJFro5Tq2uU5FOvwiKVCMd/yDGxvubtOY2HdUOFTotZZNLFON2BG/g==
X-Received: by 2002:a05:6214:21a5:: with SMTP id t5mr30882305qvc.23.1617111914067;
        Tue, 30 Mar 2021 06:45:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g11sm15745881qkk.5.2021.03.30.06.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 06:45:13 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 06/20] fpga: xrt: char dev node helper
 functions
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-7-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <755d73b9-1e23-c2e9-1502-15df14b9ed35@redhat.com>
Date:   Tue, 30 Mar 2021 06:45:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-7-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

It is unclear from the changelog if this new patch was split from an existing patch or new content.

the file ops seem to come from mgmnt/main.c, which call what could be file ops here.  why is this complicated redirection needed ?

On 3/23/21 10:29 PM, Lizhi Hou wrote:
> Helper functions for char device node creation / removal for platform
> drivers. This is part of platform driver infrastructure.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/fpga/xrt/lib/cdev.c | 232 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 232 insertions(+)
>  create mode 100644 drivers/fpga/xrt/lib/cdev.c
>
> diff --git a/drivers/fpga/xrt/lib/cdev.c b/drivers/fpga/xrt/lib/cdev.c
> new file mode 100644
> index 000000000000..38efd24b6e10
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/cdev.c
> @@ -0,0 +1,232 @@
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
> +#define XRT_CDEV_DIR		"xfpga"
maybe "xrt_fpga" or just "xrt"
> +#define INODE2PDATA(inode)	\
> +	container_of((inode)->i_cdev, struct xrt_subdev_platdata, xsp_cdev)
> +#define INODE2PDEV(inode)	\
> +	to_platform_device(kobj_to_dev((inode)->i_cdev->kobj.parent))
> +#define CDEV_NAME(sysdev)	(strchr((sysdev)->kobj.name, '!') + 1)
> +
> +/* Allow it to be accessed from cdev. */
> +static void xleaf_devnode_allowed(struct platform_device *pdev)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
> +
> +	/* Allow new opens. */
> +	mutex_lock(&pdata->xsp_devnode_lock);
> +	pdata->xsp_devnode_online = true;
> +	mutex_unlock(&pdata->xsp_devnode_lock);
> +}
> +
> +/* Turn off access from cdev and wait for all existing user to go away. */
> +static int xleaf_devnode_disallowed(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
> +
> +	mutex_lock(&pdata->xsp_devnode_lock);
> +
> +	/* Prevent new opens. */
> +	pdata->xsp_devnode_online = false;
> +	/* Wait for existing user to close. */
> +	while (!ret && pdata->xsp_devnode_ref) {
> +		int rc;
> +
> +		mutex_unlock(&pdata->xsp_devnode_lock);
> +		rc = wait_for_completion_killable(&pdata->xsp_devnode_comp);
> +		mutex_lock(&pdata->xsp_devnode_lock);
> +
> +		if (rc == -ERESTARTSYS) {
> +			/* Restore online state. */
> +			pdata->xsp_devnode_online = true;
> +			xrt_err(pdev, "%s is in use, ref=%d",
> +				CDEV_NAME(pdata->xsp_sysdev),
> +				pdata->xsp_devnode_ref);
> +			ret = -EBUSY;
> +		}
> +	}
> +
> +	mutex_unlock(&pdata->xsp_devnode_lock);
> +
> +	return ret;
> +}
> +
> +static struct platform_device *
> +__xleaf_devnode_open(struct inode *inode, bool excl)
> +{
> +	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
> +	struct platform_device *pdev = INODE2PDEV(inode);
> +	bool opened = false;
> +
> +	mutex_lock(&pdata->xsp_devnode_lock);
> +
> +	if (pdata->xsp_devnode_online) {
> +		if (excl && pdata->xsp_devnode_ref) {
> +			xrt_err(pdev, "%s has already been opened exclusively",
> +				CDEV_NAME(pdata->xsp_sysdev));
> +		} else if (!excl && pdata->xsp_devnode_excl) {
> +			xrt_err(pdev, "%s has been opened exclusively",
> +				CDEV_NAME(pdata->xsp_sysdev));
> +		} else {
> +			pdata->xsp_devnode_ref++;
> +			pdata->xsp_devnode_excl = excl;
> +			opened = true;
> +			xrt_info(pdev, "opened %s, ref=%d",
> +				 CDEV_NAME(pdata->xsp_sysdev),
> +				 pdata->xsp_devnode_ref);
> +		}
> +	} else {
> +		xrt_err(pdev, "%s is offline", CDEV_NAME(pdata->xsp_sysdev));
> +	}
> +
> +	mutex_unlock(&pdata->xsp_devnode_lock);
> +
> +	pdev = opened ? pdev : NULL;
> +	return pdev;
> +}
> +
> +struct platform_device *
> +xleaf_devnode_open_excl(struct inode *inode)
> +{
> +	return __xleaf_devnode_open(inode, true);
> +}
This function is unused, remove.
> +
> +struct platform_device *
> +xleaf_devnode_open(struct inode *inode)
> +{
> +	return __xleaf_devnode_open(inode, false);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_devnode_open);
does this really need to be exported ?
> +
> +void xleaf_devnode_close(struct inode *inode)
> +{
> +	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
> +	struct platform_device *pdev = INODE2PDEV(inode);
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
> +	if (notify) {
> +		xrt_info(pdev, "closed %s, ref=%d",
> +			 CDEV_NAME(pdata->xsp_sysdev), pdata->xsp_devnode_ref);
xsp_devnode_ref will always be 0, so no need to report it.
> +	} else {
> +		xrt_info(pdev, "closed %s, notifying waiter",
> +			 CDEV_NAME(pdata->xsp_sysdev));
> +	}
> +
> +	mutex_unlock(&pdata->xsp_devnode_lock);
> +
> +	if (notify)
> +		complete(&pdata->xsp_devnode_comp);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_devnode_close);
> +
> +static inline enum xrt_subdev_file_mode
> +devnode_mode(struct xrt_subdev_drvdata *drvdata)
> +{
> +	return drvdata->xsd_file_ops.xsf_mode;
> +}
> +
> +int xleaf_devnode_create(struct platform_device *pdev, const char *file_name,
> +			 const char *inst_name)
> +{
> +	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(pdev);
> +	struct xrt_subdev_file_ops *fops = &drvdata->xsd_file_ops;
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
> +	struct cdev *cdevp;
> +	struct device *sysdev;
> +	int ret = 0;
> +	char fname[256];
> +
> +	mutex_init(&pdata->xsp_devnode_lock);
> +	init_completion(&pdata->xsp_devnode_comp);
> +
> +	cdevp = &DEV_PDATA(pdev)->xsp_cdev;
> +	cdev_init(cdevp, &fops->xsf_ops);
> +	cdevp->owner = fops->xsf_ops.owner;
> +	cdevp->dev = MKDEV(MAJOR(fops->xsf_dev_t), pdev->id);
> +
> +	/*
> +	 * Set pdev as parent of cdev so that when pdev (and its platform
> +	 * data) will not be freed when cdev is not freed.
> +	 */
> +	cdev_set_parent(cdevp, &DEV(pdev)->kobj);
> +
> +	ret = cdev_add(cdevp, cdevp->dev, 1);
> +	if (ret) {
> +		xrt_err(pdev, "failed to add cdev: %d", ret);
> +		goto failed;
> +	}
> +	if (!file_name)
> +		file_name = pdev->name;
> +	if (!inst_name) {
> +		if (devnode_mode(drvdata) == XRT_SUBDEV_FILE_MULTI_INST) {
> +			snprintf(fname, sizeof(fname), "%s/%s/%s.%u",
> +				 XRT_CDEV_DIR, DEV_PDATA(pdev)->xsp_root_name,
> +				 file_name, pdev->id);
> +		} else {
> +			snprintf(fname, sizeof(fname), "%s/%s/%s",
> +				 XRT_CDEV_DIR, DEV_PDATA(pdev)->xsp_root_name,
> +				 file_name);
> +		}
> +	} else {
> +		snprintf(fname, sizeof(fname), "%s/%s/%s.%s", XRT_CDEV_DIR,
> +			 DEV_PDATA(pdev)->xsp_root_name, file_name, inst_name);
> +	}
> +	sysdev = device_create(xrt_class, NULL, cdevp->dev, NULL, "%s", fname);
> +	if (IS_ERR(sysdev)) {
> +		ret = PTR_ERR(sysdev);
> +		xrt_err(pdev, "failed to create device node: %d", ret);
> +		goto failed_cdev_add;
> +	}
> +	pdata->xsp_sysdev = sysdev;
> +
> +	xleaf_devnode_allowed(pdev);
> +
> +	xrt_info(pdev, "created (%d, %d): /dev/%s",
> +		 MAJOR(cdevp->dev), pdev->id, fname);
> +	return 0;
> +
> +failed_cdev_add:
> +	cdev_del(cdevp);
> +failed:
> +	cdevp->owner = NULL;
> +	return ret;
> +}
> +
> +int xleaf_devnode_destroy(struct platform_device *pdev)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
> +	struct cdev *cdevp = &pdata->xsp_cdev;
> +	dev_t dev = cdevp->dev;
> +	int rc;
> +
> +	rc = xleaf_devnode_disallowed(pdev);
> +	if (rc)
> +		return rc;

Failure of one leaf to be destroyed is not handled well.

could a able to destroy check be done over the whole group ?

Tom

> +
> +	xrt_info(pdev, "removed (%d, %d): /dev/%s/%s", MAJOR(dev), MINOR(dev),
> +		 XRT_CDEV_DIR, CDEV_NAME(pdata->xsp_sysdev));
> +	device_destroy(xrt_class, cdevp->dev);
> +	pdata->xsp_sysdev = NULL;
> +	cdev_del(cdevp);
> +	return 0;
> +}

