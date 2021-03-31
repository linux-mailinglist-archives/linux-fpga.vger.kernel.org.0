Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240993500A8
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Mar 2021 14:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhCaMuR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 Mar 2021 08:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235314AbhCaMuK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 31 Mar 2021 08:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617195008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IxVQRXLTJK/WWONgOXUUJTjaTFd3AdS6brnbYBRfu/s=;
        b=Il01diVKTQ5RZhUR2tCNd3cLPzjEY9fzveB2BNBTSCcVvX8AAdgeDUp6rCIByIrsUWzfBf
        9x42MA4JA+X0UaDE3/ppbdGW7revGtusE3JAL/s0QBhIS+3QbBSsXZQIGg8+Jyz85TjLty
        Kk+Ek6YLOP6fMCFQq4TH5h+Up0Wj8CQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-e370sEPgPwmQz4VlXrbLWA-1; Wed, 31 Mar 2021 08:50:06 -0400
X-MC-Unique: e370sEPgPwmQz4VlXrbLWA-1
Received: by mail-qv1-f72.google.com with SMTP id u7so1124073qvf.5
        for <linux-fpga@vger.kernel.org>; Wed, 31 Mar 2021 05:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IxVQRXLTJK/WWONgOXUUJTjaTFd3AdS6brnbYBRfu/s=;
        b=YzFgx1HiPu2Qz/Nox8ZqknMwGMCa08YuumO+JJ0lZaJBUxVMOBvEWBd1GahS1AqCz0
         5aWHIEHS/9TmtPXi2luc0JiUIrx59tIQkATXj/Hcp/zlyUyScCLxAz/7HUc1V6afivqs
         SWh2AwUdK9UM0DBlCiv8FHT0Hhyd3mwtkYwtBr9aS25txduYimI+uJLZrgKVcn85mYak
         e8fMn8FELTtg2e9+p+y8yEF3mfqjQcZ5NK2ImSmv3ujvIf4G4kVK2ntBARRIiqPYg2Vh
         Mi/s1fv3PObsUjyO5f8BKJY7WuMhDFOVgWomMGtVHFgF46ES+ZL/x+2EtEBzsipSyGQA
         Gy3A==
X-Gm-Message-State: AOAM533lNOPz/EwuQ9C3gfOertbpaXpweGwKadP3VudNW79Bh5YziNu4
        rv78a8XX9zqLeYtcfXFVVmVSG8PosW8z9R0uFqI3P/jRcfN3c8s5k3ri8zpYb9HFEwn1/8jVJZ+
        1G78QZ6pGgnnShGO0fa6HNQ==
X-Received: by 2002:a05:620a:102c:: with SMTP id a12mr2850951qkk.450.1617195005946;
        Wed, 31 Mar 2021 05:50:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDGru/e3xh5zXoreeLQxOswybXS5DbQyg15kKvmdS3ZkNnD2zqQaXFpSHzA/B0IuaBngfpCA==
X-Received: by 2002:a05:620a:102c:: with SMTP id a12mr2850934qkk.450.1617195005556;
        Wed, 31 Mar 2021 05:50:05 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i6sm1313210qkk.31.2021.03.31.05.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 05:50:05 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 08/20] fpga: xrt: platform driver
 infrastructure
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-9-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c87f0573-8eeb-1734-bceb-42648d404acf@redhat.com>
Date:   Wed, 31 Mar 2021 05:50:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-9-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Several just for debugging items, consider adding a CONFIG_XRT_DEBUGGING

On 3/23/21 10:29 PM, Lizhi Hou wrote:
> Infrastructure code providing APIs for managing leaf driver instance
> groups, facilitating inter-leaf driver calls and root calls.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/fpga/xrt/lib/subdev.c | 865 ++++++++++++++++++++++++++++++++++
>  1 file changed, 865 insertions(+)
>  create mode 100644 drivers/fpga/xrt/lib/subdev.c
>
> diff --git a/drivers/fpga/xrt/lib/subdev.c b/drivers/fpga/xrt/lib/subdev.c
> new file mode 100644
> index 000000000000..6428b183fee3
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/subdev.c
> @@ -0,0 +1,865 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/pci.h>
> +#include <linux/vmalloc.h>
> +#include "xleaf.h"
> +#include "subdev_pool.h"
> +#include "lib-drv.h"
> +#include "metadata.h"
> +
> +#define IS_ROOT_DEV(dev) ((dev)->bus == &pci_bus_type)
for readablity, add a new line here
> +static inline struct device *find_root(struct platform_device *pdev)
> +{
> +	struct device *d = DEV(pdev);
> +
> +	while (!IS_ROOT_DEV(d))
> +		d = d->parent;
> +	return d;
> +}
> +
> +/*
> + * It represents a holder of a subdev. One holder can repeatedly hold a subdev
> + * as long as there is a unhold corresponding to a hold.
> + */
> +struct xrt_subdev_holder {
> +	struct list_head xsh_holder_list;
> +	struct device *xsh_holder;
> +	int xsh_count;
> +	struct kref xsh_kref;
> +};
> +
> +/*
> + * It represents a specific instance of platform driver for a subdev, which
> + * provides services to its clients (another subdev driver or root driver).
> + */
> +struct xrt_subdev {
> +	struct list_head xs_dev_list;
> +	struct list_head xs_holder_list;
> +	enum xrt_subdev_id xs_id;		/* type of subdev */
> +	struct platform_device *xs_pdev;	/* a particular subdev inst */
> +	struct completion xs_holder_comp;
> +};
> +
> +static struct xrt_subdev *xrt_subdev_alloc(void)
> +{
> +	struct xrt_subdev *sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
ok
> +
> +	if (!sdev)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&sdev->xs_dev_list);
> +	INIT_LIST_HEAD(&sdev->xs_holder_list);
> +	init_completion(&sdev->xs_holder_comp);
> +	return sdev;
> +}
> +
> +static void xrt_subdev_free(struct xrt_subdev *sdev)
> +{
> +	kfree(sdev);
Abstraction for a single function is not needed, use kfree directly.
> +}
> +
> +int xrt_subdev_root_request(struct platform_device *self, u32 cmd, void *arg)
> +{
> +	struct device *dev = DEV(self);
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(self);
> +
> +	WARN_ON(!pdata->xsp_root_cb);
ok
> +	return (*pdata->xsp_root_cb)(dev->parent, pdata->xsp_root_cb_arg, cmd, arg);
> +}
> +
> +/*
> + * Subdev common sysfs nodes.
> + */
> +static ssize_t holders_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	ssize_t len;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct xrt_root_get_holders holders = { pdev, buf, 1024 };
Since 1024 is config, #define it somewhere so it can be tweeked later
> +
> +	len = xrt_subdev_root_request(pdev, XRT_ROOT_GET_LEAF_HOLDERS, &holders);
> +	if (len >= holders.xpigh_holder_buf_len)
> +		return len;
> +	buf[len] = '\n';
> +	return len + 1;
> +}
> +static DEVICE_ATTR_RO(holders);
> +
> +static struct attribute *xrt_subdev_attrs[] = {
> +	&dev_attr_holders.attr,
> +	NULL,
> +};
> +
> +static ssize_t metadata_output(struct file *filp, struct kobject *kobj,
> +			       struct bin_attribute *attr, char *buf, loff_t off, size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
> +	unsigned char *blob;
> +	unsigned long  size;
> +	ssize_t ret = 0;
> +
> +	blob = pdata->xsp_dtb;
> +	size = xrt_md_size(dev, blob);
> +	if (size == XRT_MD_INVALID_LENGTH) {
> +		ret = -EINVAL;
> +		goto failed;
> +	}
> +
> +	if (off >= size)
> +		goto failed;
if this and next are used for debugging, add a 'dev_dbg()' to help out the debugging.
> +
> +	if (off + count > size)
> +		count = size - off;
> +	memcpy(buf, blob + off, count);
> +
> +	ret = count;
> +failed:
> +	return ret;
> +}
> +
> +static struct bin_attribute meta_data_attr = {
> +	.attr = {
> +		.name = "metadata",
> +		.mode = 0400
> +	},

Permissions will not be enough, anyone can be root.

A developer only interface should be hidden behind a CONFIG_

> +	.read = metadata_output,
> +	.size = 0
> +};
> +
> +static struct bin_attribute  *xrt_subdev_bin_attrs[] = {
> +	&meta_data_attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group xrt_subdev_attrgroup = {
> +	.attrs = xrt_subdev_attrs,
> +	.bin_attrs = xrt_subdev_bin_attrs,
> +};
> +
> +/*
> + * Given the device metadata, parse it to get IO ranges and construct
> + * resource array.
> + */
> +static int
> +xrt_subdev_getres(struct device *parent, enum xrt_subdev_id id,
> +		  char *dtb, struct resource **res, int *res_num)
> +{
> +	struct xrt_subdev_platdata *pdata;
> +	struct resource *pci_res = NULL;
> +	const u64 *bar_range;
> +	const u32 *bar_idx;
> +	char *ep_name = NULL, *regmap = NULL;
> +	uint bar;
> +	int count1 = 0, count2 = 0, ret;
> +
> +	if (!dtb)
> +		return -EINVAL;
> +
> +	pdata = DEV_PDATA(to_platform_device(parent));
> +
> +	/* go through metadata and count endpoints in it */
> +	for (xrt_md_get_next_endpoint(parent, dtb, NULL, NULL, &ep_name, &regmap); ep_name;

Embedding functions in the for-loop is difficult to debug consider change this loop into something easier to read.

Maybe

xrt_md_get_next_endpoint(parent, dtb, NULL, NULL, &ep_name, &regmap);

while (ep_name) {

...

xrt_md_get_next_endpoint(parent, dtb, ep_name, regmap, &ep_name, &regmap)

}

similar below

> +	     xrt_md_get_next_endpoint(parent, dtb, ep_name, regmap, &ep_name, &regmap)) {
> +		ret = xrt_md_get_prop(parent, dtb, ep_name, regmap,
> +				      XRT_MD_PROP_IO_OFFSET, (const void **)&bar_range, NULL);
> +		if (!ret)
> +			count1++;
> +	}
> +	if (!count1)
> +		return 0;
> +
> +	/* allocate resource array for all endpoints been found in metadata */
> +	*res = vzalloc(sizeof(**res) * count1);
if this is small, convert to kzalloc
> +
> +	/* go through all endpoints again and get IO range for each endpoint */
> +	for (xrt_md_get_next_endpoint(parent, dtb, NULL, NULL, &ep_name, &regmap); ep_name;
> +	     xrt_md_get_next_endpoint(parent, dtb, ep_name, regmap, &ep_name, &regmap)) {
> +		ret = xrt_md_get_prop(parent, dtb, ep_name, regmap,
> +				      XRT_MD_PROP_IO_OFFSET, (const void **)&bar_range, NULL);
> +		if (ret)
> +			continue;
> +		xrt_md_get_prop(parent, dtb, ep_name, regmap,
> +				XRT_MD_PROP_BAR_IDX, (const void **)&bar_idx, NULL);
> +		bar = bar_idx ? be32_to_cpu(*bar_idx) : 0;
> +		xleaf_get_barres(to_platform_device(parent), &pci_res, bar);
> +		(*res)[count2].start = pci_res->start +
> +			be64_to_cpu(bar_range[0]);
> +		(*res)[count2].end = pci_res->start +
> +			be64_to_cpu(bar_range[0]) +
> +			be64_to_cpu(bar_range[1]) - 1;
> +		(*res)[count2].flags = IORESOURCE_MEM;
> +		/* check if there is conflicted resource */
> +		ret = request_resource(pci_res, *res + count2);
> +		if (ret) {
> +			dev_err(parent, "Conflict resource %pR\n", *res + count2);
> +			vfree(*res);
> +			*res_num = 0;
> +			*res = NULL;
> +			return ret;
> +		}
> +		release_resource(*res + count2);
> +
> +		(*res)[count2].parent = pci_res;
> +
> +		xrt_md_find_endpoint(parent, pdata->xsp_dtb, ep_name,
> +				     regmap, &(*res)[count2].name);
> +
> +		count2++;
> +	}
> +
> +	WARN_ON(count1 != count2);
> +	*res_num = count2;
> +
> +	return 0;
> +}
> +
> +static inline enum xrt_subdev_file_mode
> +xleaf_devnode_mode(struct xrt_subdev_drvdata *drvdata)
> +{
> +	return drvdata->xsd_file_ops.xsf_mode;
> +}
> +
> +static bool xrt_subdev_cdev_auto_creation(struct platform_device *pdev)
> +{
> +	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(pdev);
> +	enum xrt_subdev_file_mode mode = xleaf_devnode_mode(drvdata);
> +
> +	if (!drvdata)
> +		return false;
> +
> +	if (!xleaf_devnode_enabled(drvdata))
> +		return false;
> +
> +	return (mode == XRT_SUBDEV_FILE_DEFAULT || mode == XRT_SUBDEV_FILE_MULTI_INST);

should this check happen before xleaf_devnode_enable() ?


> +}
> +
> +static struct xrt_subdev *
> +xrt_subdev_create(struct device *parent, enum xrt_subdev_id id,
> +		  xrt_subdev_root_cb_t pcb, void *pcb_arg, char *dtb)
> +{
> +	struct xrt_subdev_platdata *pdata = NULL;
> +	struct platform_device *pdev = NULL;
> +	int inst = PLATFORM_DEVID_NONE;
> +	struct xrt_subdev *sdev = NULL;
> +	struct resource *res = NULL;
> +	unsigned long dtb_len = 0;
> +	int res_num = 0;
> +	size_t pdata_sz;
> +	int ret;
> +
> +	sdev = xrt_subdev_alloc();
> +	if (!sdev) {
> +		dev_err(parent, "failed to alloc subdev for ID %d", id);
> +		goto fail;
> +	}
> +	sdev->xs_id = id;
> +
> +	if (!dtb) {
> +		ret = xrt_md_create(parent, &dtb);
> +		if (ret) {
> +			dev_err(parent, "can't create empty dtb: %d", ret);
> +			goto fail;
> +		}
> +	}
> +	xrt_md_pack(parent, dtb);
> +	dtb_len = xrt_md_size(parent, dtb);
> +	if (dtb_len == XRT_MD_INVALID_LENGTH) {
> +		dev_err(parent, "invalid metadata len %ld", dtb_len);
> +		goto fail;
> +	}
> +	pdata_sz = sizeof(struct xrt_subdev_platdata) + dtb_len;
ok
> +
> +	/* Prepare platform data passed to subdev. */
> +	pdata = vzalloc(pdata_sz);
> +	if (!pdata)
> +		goto fail;
> +
> +	pdata->xsp_root_cb = pcb;
> +	pdata->xsp_root_cb_arg = pcb_arg;
> +	memcpy(pdata->xsp_dtb, dtb, dtb_len);
> +	if (id == XRT_SUBDEV_GRP) {
> +		/* Group can only be created by root driver. */
> +		pdata->xsp_root_name = dev_name(parent);
> +	} else {
> +		struct platform_device *grp = to_platform_device(parent);
> +		/* Leaf can only be created by group driver. */
> +		WARN_ON(strncmp(xrt_drv_name(XRT_SUBDEV_GRP),
> +				platform_get_device_id(grp)->name,
> +				strlen(xrt_drv_name(XRT_SUBDEV_GRP)) + 1));
> +		pdata->xsp_root_name = DEV_PDATA(grp)->xsp_root_name;
> +	}
> +
> +	/* Obtain dev instance number. */
> +	inst = xrt_drv_get_instance(id);
> +	if (inst < 0) {
> +		dev_err(parent, "failed to obtain instance: %d", inst);
> +		goto fail;
> +	}
> +
> +	/* Create subdev. */
> +	if (id != XRT_SUBDEV_GRP) {
> +		int rc = xrt_subdev_getres(parent, id, dtb, &res, &res_num);
> +
> +		if (rc) {
> +			dev_err(parent, "failed to get resource for %s.%d: %d",
> +				xrt_drv_name(id), inst, rc);
> +			goto fail;
> +		}
> +	}
> +	pdev = platform_device_register_resndata(parent, xrt_drv_name(id),
> +						 inst, res, res_num, pdata, pdata_sz);
ok
> +	vfree(res);
> +	if (IS_ERR(pdev)) {
> +		dev_err(parent, "failed to create subdev for %s inst %d: %ld",
> +			xrt_drv_name(id), inst, PTR_ERR(pdev));
> +		goto fail;
> +	}
> +	sdev->xs_pdev = pdev;
> +
> +	if (device_attach(DEV(pdev)) != 1) {
> +		xrt_err(pdev, "failed to attach");
> +		goto fail;
> +	}
> +
> +	if (sysfs_create_group(&DEV(pdev)->kobj, &xrt_subdev_attrgroup))
> +		xrt_err(pdev, "failed to create sysfs group");
> +
> +	/*
> +	 * Create sysfs sym link under root for leaves
> +	 * under random groups for easy access to them.
> +	 */
> +	if (id != XRT_SUBDEV_GRP) {
> +		if (sysfs_create_link(&find_root(pdev)->kobj,
> +				      &DEV(pdev)->kobj, dev_name(DEV(pdev)))) {
> +			xrt_err(pdev, "failed to create sysfs link");
> +		}
> +	}
> +
> +	/* All done, ready to handle req thru cdev. */
> +	if (xrt_subdev_cdev_auto_creation(pdev))
> +		xleaf_devnode_create(pdev, DEV_DRVDATA(pdev)->xsd_file_ops.xsf_dev_name, NULL);
> +
> +	vfree(pdata);
> +	return sdev;
> +
> +fail:

Take another look at splitting this error handling.

Jumping to specific labels is more common.

> +	vfree(pdata);
> +	if (sdev && !IS_ERR_OR_NULL(sdev->xs_pdev))
> +		platform_device_unregister(sdev->xs_pdev);
> +	if (inst >= 0)
> +		xrt_drv_put_instance(id, inst);
> +	xrt_subdev_free(sdev);
> +	return NULL;
> +}
> +
> +static void xrt_subdev_destroy(struct xrt_subdev *sdev)
> +{
> +	struct platform_device *pdev = sdev->xs_pdev;
> +	struct device *dev = DEV(pdev);
> +	int inst = pdev->id;
> +	int ret;
> +
> +	/* Take down the device node */
> +	if (xrt_subdev_cdev_auto_creation(pdev)) {
> +		ret = xleaf_devnode_destroy(pdev);
> +		WARN_ON(ret);
> +	}
> +	if (sdev->xs_id != XRT_SUBDEV_GRP)
> +		sysfs_remove_link(&find_root(pdev)->kobj, dev_name(dev));
> +	sysfs_remove_group(&dev->kobj, &xrt_subdev_attrgroup);
> +	platform_device_unregister(pdev);
> +	xrt_drv_put_instance(sdev->xs_id, inst);
> +	xrt_subdev_free(sdev);
> +}
> +
> +struct platform_device *
> +xleaf_get_leaf(struct platform_device *pdev, xrt_subdev_match_t match_cb, void *match_arg)
> +{
> +	int rc;
> +	struct xrt_root_get_leaf get_leaf = {
> +		pdev, match_cb, match_arg, };
> +
> +	rc = xrt_subdev_root_request(pdev, XRT_ROOT_GET_LEAF, &get_leaf);
> +	if (rc)
> +		return NULL;
> +	return get_leaf.xpigl_tgt_pdev;
> +}
> +EXPORT_SYMBOL_GPL(xleaf_get_leaf);
> +
> +bool xleaf_has_endpoint(struct platform_device *pdev, const char *endpoint_name)
> +{
> +	struct resource	*res;
> +	int i = 0;
ok
> +
> +	do {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (res && !strncmp(res->name, endpoint_name, strlen(res->name) + 1))
> +			return true;
> +		++i;
ok
> +	} while (res);
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(xleaf_has_endpoint);
> +
> +int xleaf_put_leaf(struct platform_device *pdev, struct platform_device *leaf)
> +{
> +	struct xrt_root_put_leaf put_leaf = { pdev, leaf };
> +
> +	return xrt_subdev_root_request(pdev, XRT_ROOT_PUT_LEAF, &put_leaf);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_put_leaf);
> +
> +int xleaf_create_group(struct platform_device *pdev, char *dtb)
> +{
> +	return xrt_subdev_root_request(pdev, XRT_ROOT_CREATE_GROUP, dtb);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_create_group);
> +
> +int xleaf_destroy_group(struct platform_device *pdev, int instance)
> +{
> +	return xrt_subdev_root_request(pdev, XRT_ROOT_REMOVE_GROUP, (void *)(uintptr_t)instance);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_destroy_group);
> +
> +int xleaf_wait_for_group_bringup(struct platform_device *pdev)
> +{
> +	return xrt_subdev_root_request(pdev, XRT_ROOT_WAIT_GROUP_BRINGUP, NULL);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_wait_for_group_bringup);
> +
> +static ssize_t
> +xrt_subdev_get_holders(struct xrt_subdev *sdev, char *buf, size_t len)
> +{
> +	const struct list_head *ptr;
> +	struct xrt_subdev_holder *h;
> +	ssize_t n = 0;
> +
> +	list_for_each(ptr, &sdev->xs_holder_list) {
> +		h = list_entry(ptr, struct xrt_subdev_holder, xsh_holder_list);
> +		n += snprintf(buf + n, len - n, "%s:%d ",
> +			      dev_name(h->xsh_holder), kref_read(&h->xsh_kref));
add a comment that truncation is fine
> +		if (n >= (len - 1))
> +			break;
> +	}
> +	return n;
> +}
> +
> +void xrt_subdev_pool_init(struct device *dev, struct xrt_subdev_pool *spool)
> +{
> +	INIT_LIST_HEAD(&spool->xsp_dev_list);
> +	spool->xsp_owner = dev;
> +	mutex_init(&spool->xsp_lock);
> +	spool->xsp_closing = false;
> +}
> +
> +static void xrt_subdev_free_holder(struct xrt_subdev_holder *holder)
> +{
> +	list_del(&holder->xsh_holder_list);
> +	vfree(holder);
> +}
> +
> +static void xrt_subdev_pool_wait_for_holders(struct xrt_subdev_pool *spool, struct xrt_subdev *sdev)
> +{
> +	const struct list_head *ptr, *next;
> +	char holders[128];
> +	struct xrt_subdev_holder *holder;
> +	struct mutex *lk = &spool->xsp_lock;
> +
> +	while (!list_empty(&sdev->xs_holder_list)) {
> +		int rc;
> +
> +		/* It's most likely a bug if we ever enters this loop. */
> +		xrt_subdev_get_holders(sdev, holders, sizeof(holders));
Items just for debugging need to run just for debugging
> +		xrt_err(sdev->xs_pdev, "awaits holders: %s", holders);
> +		mutex_unlock(lk);
> +		rc = wait_for_completion_killable(&sdev->xs_holder_comp);
> +		mutex_lock(lk);
> +		if (rc == -ERESTARTSYS) {
> +			xrt_err(sdev->xs_pdev, "give up on waiting for holders, clean up now");
> +			list_for_each_safe(ptr, next, &sdev->xs_holder_list) {
> +				holder = list_entry(ptr, struct xrt_subdev_holder, xsh_holder_list);
> +				xrt_subdev_free_holder(holder);
> +			}
> +		}
> +	}
> +}
> +
> +void xrt_subdev_pool_fini(struct xrt_subdev_pool *spool)
> +{
> +	struct list_head *dl = &spool->xsp_dev_list;
> +	struct mutex *lk = &spool->xsp_lock;
> +
> +	mutex_lock(lk);
> +	if (spool->xsp_closing) {
> +		mutex_unlock(lk);
> +		return;
> +	}
> +	spool->xsp_closing = true;
> +	mutex_unlock(lk);
ok
> +
> +	/* Remove subdev in the reverse order of added. */
> +	while (!list_empty(dl)) {
> +		struct xrt_subdev *sdev = list_first_entry(dl, struct xrt_subdev, xs_dev_list);
> +
> +		xrt_subdev_pool_wait_for_holders(spool, sdev);
> +		list_del(&sdev->xs_dev_list);
> +		xrt_subdev_destroy(sdev);
> +	}
> +}
> +
> +static struct xrt_subdev_holder *xrt_subdev_find_holder(struct xrt_subdev *sdev,
> +							struct device *holder_dev)
> +{
> +	struct list_head *hl = &sdev->xs_holder_list;
> +	struct xrt_subdev_holder *holder;
> +	const struct list_head *ptr;
> +
> +	list_for_each(ptr, hl) {
> +		holder = list_entry(ptr, struct xrt_subdev_holder, xsh_holder_list);
> +		if (holder->xsh_holder == holder_dev)
> +			return holder;
> +	}
> +	return NULL;
> +}
> +
> +static int xrt_subdev_hold(struct xrt_subdev *sdev, struct device *holder_dev)
> +{
> +	struct xrt_subdev_holder *holder = xrt_subdev_find_holder(sdev, holder_dev);
> +	struct list_head *hl = &sdev->xs_holder_list;
> +
> +	if (!holder) {
> +		holder = vzalloc(sizeof(*holder));
> +		if (!holder)
> +			return -ENOMEM;
> +		holder->xsh_holder = holder_dev;
> +		kref_init(&holder->xsh_kref);
> +		list_add_tail(&holder->xsh_holder_list, hl);
> +	} else {
> +		kref_get(&holder->xsh_kref);
> +	}
> +
> +	return 0;
> +}
> +
> +static void xrt_subdev_free_holder_kref(struct kref *kref)
> +{
> +	struct xrt_subdev_holder *holder = container_of(kref, struct xrt_subdev_holder, xsh_kref);
> +
> +	xrt_subdev_free_holder(holder);
> +}
> +
> +static int
> +xrt_subdev_release(struct xrt_subdev *sdev, struct device *holder_dev)
> +{
> +	struct xrt_subdev_holder *holder = xrt_subdev_find_holder(sdev, holder_dev);
> +	struct list_head *hl = &sdev->xs_holder_list;
> +
> +	if (!holder) {
> +		dev_err(holder_dev, "can't release, %s did not hold %s",
> +			dev_name(holder_dev), dev_name(DEV(sdev->xs_pdev)));
> +		return -EINVAL;
> +	}
> +	kref_put(&holder->xsh_kref, xrt_subdev_free_holder_kref);
> +
> +	/* kref_put above may remove holder from list. */
> +	if (list_empty(hl))
> +		complete(&sdev->xs_holder_comp);
> +	return 0;
> +}
> +
> +int xrt_subdev_pool_add(struct xrt_subdev_pool *spool, enum xrt_subdev_id id,
> +			xrt_subdev_root_cb_t pcb, void *pcb_arg, char *dtb)
> +{
> +	struct mutex *lk = &spool->xsp_lock;
> +	struct list_head *dl = &spool->xsp_dev_list;
> +	struct xrt_subdev *sdev;
> +	int ret = 0;
> +
> +	sdev = xrt_subdev_create(spool->xsp_owner, id, pcb, pcb_arg, dtb);
> +	if (sdev) {
> +		mutex_lock(lk);
> +		if (spool->xsp_closing) {
> +			/* No new subdev when pool is going away. */
> +			xrt_err(sdev->xs_pdev, "pool is closing");
> +			ret = -ENODEV;
> +		} else {
> +			list_add(&sdev->xs_dev_list, dl);
> +		}
> +		mutex_unlock(lk);
> +		if (ret)
> +			xrt_subdev_destroy(sdev);
> +	} else {
> +		ret = -EINVAL;
> +	}
> +
> +	ret = ret ? ret : sdev->xs_pdev->id;
> +	return ret;
> +}
> +
> +int xrt_subdev_pool_del(struct xrt_subdev_pool *spool, enum xrt_subdev_id id, int instance)
> +{
> +	const struct list_head *ptr;
> +	struct mutex *lk = &spool->xsp_lock;
> +	struct list_head *dl = &spool->xsp_dev_list;
> +	struct xrt_subdev *sdev;
> +	int ret = -ENOENT;
> +
> +	mutex_lock(lk);
> +	if (spool->xsp_closing) {
> +		/* Pool is going away, all subdevs will be gone. */
> +		mutex_unlock(lk);
> +		return 0;
> +	}
> +	list_for_each(ptr, dl) {
> +		sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
> +		if (sdev->xs_id != id || sdev->xs_pdev->id != instance)
> +			continue;
> +		xrt_subdev_pool_wait_for_holders(spool, sdev);
> +		list_del(&sdev->xs_dev_list);
> +		ret = 0;
> +		break;
> +	}
> +	mutex_unlock(lk);
> +	if (ret)
> +		return ret;
> +
> +	xrt_subdev_destroy(sdev);
> +	return 0;
> +}
> +
> +static int xrt_subdev_pool_get_impl(struct xrt_subdev_pool *spool, xrt_subdev_match_t match,
> +				    void *arg, struct device *holder_dev, struct xrt_subdev **sdevp)
> +{
> +	struct platform_device *pdev = (struct platform_device *)arg;
> +	struct list_head *dl = &spool->xsp_dev_list;
> +	struct mutex *lk = &spool->xsp_lock;
> +	struct xrt_subdev *sdev = NULL;
> +	const struct list_head *ptr;
> +	struct xrt_subdev *d = NULL;
> +	int ret = -ENOENT;
> +
> +	mutex_lock(lk);
> +
> +	if (!pdev) {
> +		if (match == XRT_SUBDEV_MATCH_PREV) {
> +			sdev = list_empty(dl) ? NULL :
> +				list_last_entry(dl, struct xrt_subdev, xs_dev_list);
> +		} else if (match == XRT_SUBDEV_MATCH_NEXT) {
> +			sdev = list_first_entry_or_null(dl, struct xrt_subdev, xs_dev_list);
> +		}
> +	}
> +
> +	list_for_each(ptr, dl) {
ok
> +		d = list_entry(ptr, struct xrt_subdev, xs_dev_list);
> +		if (match == XRT_SUBDEV_MATCH_PREV || match == XRT_SUBDEV_MATCH_NEXT) {
> +			if (d->xs_pdev != pdev)
> +				continue;
> +		} else {
> +			if (!match(d->xs_id, d->xs_pdev, arg))
> +				continue;
> +		}
> +
> +		if (match == XRT_SUBDEV_MATCH_PREV)
> +			sdev = !list_is_first(ptr, dl) ? list_prev_entry(d, xs_dev_list) : NULL;
> +		else if (match == XRT_SUBDEV_MATCH_NEXT)
> +			sdev = !list_is_last(ptr, dl) ? list_next_entry(d, xs_dev_list) : NULL;
> +		else
> +			sdev = d;
> +	}
> +
> +	if (sdev)
> +		ret = xrt_subdev_hold(sdev, holder_dev);
> +
> +	mutex_unlock(lk);
> +
> +	if (!ret)
> +		*sdevp = sdev;
> +	return ret;
> +}
> +
> +int xrt_subdev_pool_get(struct xrt_subdev_pool *spool, xrt_subdev_match_t match, void *arg,
> +			struct device *holder_dev, struct platform_device **pdevp)
> +{
> +	int rc;
> +	struct xrt_subdev *sdev;
> +
> +	rc = xrt_subdev_pool_get_impl(spool, match, arg, holder_dev, &sdev);
> +	if (rc) {
> +		if (rc != -ENOENT)
> +			dev_err(holder_dev, "failed to hold device: %d", rc);
> +		return rc;
> +	}
> +
> +	if (!IS_ROOT_DEV(holder_dev)) {
ok
> +		xrt_dbg(to_platform_device(holder_dev), "%s <<==== %s",
> +			dev_name(holder_dev), dev_name(DEV(sdev->xs_pdev)));
> +	}
> +
> +	*pdevp = sdev->xs_pdev;
> +	return 0;
> +}
> +
> +static int xrt_subdev_pool_put_impl(struct xrt_subdev_pool *spool, struct platform_device *pdev,
> +				    struct device *holder_dev)
> +{
> +	const struct list_head *ptr;
> +	struct mutex *lk = &spool->xsp_lock;
> +	struct list_head *dl = &spool->xsp_dev_list;
> +	struct xrt_subdev *sdev;
> +	int ret = -ENOENT;
> +
> +	mutex_lock(lk);
> +	list_for_each(ptr, dl) {
> +		sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
> +		if (sdev->xs_pdev != pdev)
> +			continue;
> +		ret = xrt_subdev_release(sdev, holder_dev);
> +		break;
> +	}
> +	mutex_unlock(lk);
> +
> +	return ret;
> +}
> +
> +int xrt_subdev_pool_put(struct xrt_subdev_pool *spool, struct platform_device *pdev,
> +			struct device *holder_dev)
> +{
> +	int ret = xrt_subdev_pool_put_impl(spool, pdev, holder_dev);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!IS_ROOT_DEV(holder_dev)) {
ok
> +		xrt_dbg(to_platform_device(holder_dev), "%s <<==X== %s",
> +			dev_name(holder_dev), dev_name(DEV(pdev)));
> +	}
> +	return 0;
> +}
> +
> +void xrt_subdev_pool_trigger_event(struct xrt_subdev_pool *spool, enum xrt_events e)
> +{
> +	struct platform_device *tgt = NULL;
> +	struct xrt_subdev *sdev = NULL;
> +	struct xrt_event evt;
> +
> +	while (!xrt_subdev_pool_get_impl(spool, XRT_SUBDEV_MATCH_NEXT,
> +					 tgt, spool->xsp_owner, &sdev)) {
> +		tgt = sdev->xs_pdev;
> +		evt.xe_evt = e;
> +		evt.xe_subdev.xevt_subdev_id = sdev->xs_id;
> +		evt.xe_subdev.xevt_subdev_instance = tgt->id;
> +		xrt_subdev_root_request(tgt, XRT_ROOT_EVENT_SYNC, &evt);
> +		xrt_subdev_pool_put_impl(spool, tgt, spool->xsp_owner);
> +	}
> +}
> +
> +void xrt_subdev_pool_handle_event(struct xrt_subdev_pool *spool, struct xrt_event *evt)
> +{
> +	struct platform_device *tgt = NULL;
> +	struct xrt_subdev *sdev = NULL;
> +
> +	while (!xrt_subdev_pool_get_impl(spool, XRT_SUBDEV_MATCH_NEXT,
> +					 tgt, spool->xsp_owner, &sdev)) {
> +		tgt = sdev->xs_pdev;
> +		xleaf_call(tgt, XRT_XLEAF_EVENT, evt);
> +		xrt_subdev_pool_put_impl(spool, tgt, spool->xsp_owner);
> +	}
> +}
> +
> +ssize_t xrt_subdev_pool_get_holders(struct xrt_subdev_pool *spool,
> +				    struct platform_device *pdev, char *buf, size_t len)
> +{
> +	const struct list_head *ptr;
> +	struct mutex *lk = &spool->xsp_lock;
> +	struct list_head *dl = &spool->xsp_dev_list;
> +	struct xrt_subdev *sdev;
> +	ssize_t ret = 0;
> +
> +	mutex_lock(lk);
> +	list_for_each(ptr, dl) {
> +		sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
> +		if (sdev->xs_pdev != pdev)
> +			continue;
> +		ret = xrt_subdev_get_holders(sdev, buf, len);
> +		break;
> +	}
> +	mutex_unlock(lk);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_subdev_pool_get_holders);
> +
> +int xleaf_broadcast_event(struct platform_device *pdev, enum xrt_events evt, bool async)
> +{
> +	struct xrt_event e = { evt, };
> +	enum xrt_root_cmd cmd = async ? XRT_ROOT_EVENT_ASYNC : XRT_ROOT_EVENT_SYNC;
> +
> +	WARN_ON(evt == XRT_EVENT_POST_CREATION || evt == XRT_EVENT_PRE_REMOVAL);
> +	return xrt_subdev_root_request(pdev, cmd, &e);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_broadcast_event);
> +
> +void xleaf_hot_reset(struct platform_device *pdev)
> +{
> +	xrt_subdev_root_request(pdev, XRT_ROOT_HOT_RESET, NULL);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_hot_reset);
> +
> +void xleaf_get_barres(struct platform_device *pdev, struct resource **res, uint bar_idx)
> +{
> +	struct xrt_root_get_res arg = { 0 };
> +
> +	if (bar_idx > PCI_STD_RESOURCE_END) {
> +		xrt_err(pdev, "Invalid bar idx %d", bar_idx);
> +		*res = NULL;
> +		return;
> +	}
> +
> +	xrt_subdev_root_request(pdev, XRT_ROOT_GET_RESOURCE, &arg);
> +
> +	*res = &arg.xpigr_res[bar_idx];
> +}
> +
> +void xleaf_get_root_id(struct platform_device *pdev, unsigned short *vendor, unsigned short *device,
> +		       unsigned short *subvendor, unsigned short *subdevice)
> +{
> +	struct xrt_root_get_id id = { 0 };
> +
> +	WARN_ON(!vendor && !device && !subvendor && !subdevice);

ok

Tom

> +
> +	xrt_subdev_root_request(pdev, XRT_ROOT_GET_ID, (void *)&id);
> +	if (vendor)
> +		*vendor = id.xpigi_vendor_id;
> +	if (device)
> +		*device = id.xpigi_device_id;
> +	if (subvendor)
> +		*subvendor = id.xpigi_sub_vendor_id;
> +	if (subdevice)
> +		*subdevice = id.xpigi_sub_device_id;
> +}
> +
> +struct device *xleaf_register_hwmon(struct platform_device *pdev, const char *name, void *drvdata,
> +				    const struct attribute_group **grps)
> +{
> +	struct xrt_root_hwmon hm = { true, name, drvdata, grps, };
> +
> +	xrt_subdev_root_request(pdev, XRT_ROOT_HWMON, (void *)&hm);
> +	return hm.xpih_hwmon_dev;
> +}
> +
> +void xleaf_unregister_hwmon(struct platform_device *pdev, struct device *hwmon)
> +{
> +	struct xrt_root_hwmon hm = { false, };
> +
> +	hm.xpih_hwmon_dev = hwmon;
> +	xrt_subdev_root_request(pdev, XRT_ROOT_HWMON, (void *)&hm);
> +}

