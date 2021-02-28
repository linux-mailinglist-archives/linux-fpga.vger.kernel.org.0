Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8103A32735A
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Feb 2021 17:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhB1QiG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Feb 2021 11:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230408AbhB1QiF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 28 Feb 2021 11:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614530169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLZgAZBn851XlkYkSAvIsojlN6u4ubfcdL8PqbRvcBM=;
        b=DssHr6bIspP4xX2Y/qDt7G2PbJSOvTLl0avJoM5Tu0RqWtlPqw61Okqoev0p0/TvgvRtAN
        TSp0u8rv82XOaczGRBgi701mbQlP/er13WiHDb5EsSRDDdk409oPR35mLcUep9uxSgq57h
        QbPcdMq7qGd4P5ZFY91oqvl7mReaDlw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-4uJhmbBuPwOeY5irUXq9JQ-1; Sun, 28 Feb 2021 11:36:06 -0500
X-MC-Unique: 4uJhmbBuPwOeY5irUXq9JQ-1
Received: by mail-qt1-f197.google.com with SMTP id o7so9289009qtw.7
        for <linux-fpga@vger.kernel.org>; Sun, 28 Feb 2021 08:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SLZgAZBn851XlkYkSAvIsojlN6u4ubfcdL8PqbRvcBM=;
        b=UsqebBgfNe3+k/HUhq9eBzbMqwygEcO/bPQIXgF7mS9UH5DPhmzy9Aj6MG7quihdZG
         CM7/aIQ0jpWBz3fOeUpVZKVxggdg91kRQMvVia/1EccKBUjmzpF5nyX5FdTM57cyT6Bb
         PadQ7R9rkWA//cSVBNfUU49EY+ILqEWx/F5uoQw+MLkcO88UxcDaL18Cy8SUcVMLkvSo
         c3QdAs2rYDrrDf4ogg6+nCv4ZoflLLQ/QOj5avF0WYaUM+bbS/RQPov1rtm0NIrZ4ObI
         MtSrlRQLZ2m0hZuKTAK+QlFaAFiPvGWBQAd6B2/kE+ssTiIGpkxJLicILYixDhSFcluE
         ZzuA==
X-Gm-Message-State: AOAM530IwhCxFhUdt9fNTgK4LmKXrRaoGvMZVJ0U0yN93uPP9v8ccqvt
        Fb1s6pDWbgPQIgrJ1MdC77561ZtuOZvIsXvJn6or5O2qngxYHKEFnWIpG/lTh1ya9lY6WDJUJvX
        tE1TBMv5VNqWWo7PaDvKTug==
X-Received: by 2002:ac8:5b8e:: with SMTP id a14mr8136764qta.189.1614530165082;
        Sun, 28 Feb 2021 08:36:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYTRbaXDPIwU1vXidzSSp8dWEbFf6iAz0m5YR5F7jgIz+30rzx/ACjiDf4MzBIPV3xlTxYSA==
X-Received: by 2002:ac8:5b8e:: with SMTP id a14mr8136727qta.189.1614530164563;
        Sun, 28 Feb 2021 08:36:04 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m30sm8603782qtd.30.2021.02.28.08.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 08:36:04 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 09/18] fpga: xrt: fpga-mgr and region
 implementation for xclbin download
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-10-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <bebfc250-fef3-3f92-e962-f485fd14110a@redhat.com>
Date:   Sun, 28 Feb 2021 08:36:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-10-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
> fpga-mgr and region implementation for xclbin download which will be
> called from main platform driver
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/mgmt/fmgr-drv.c    | 187 +++++++++++
>  drivers/fpga/xrt/mgmt/fmgr.h        |  28 ++
>  drivers/fpga/xrt/mgmt/main-region.c | 471 ++++++++++++++++++++++++++++
>  3 files changed, 686 insertions(+)
>  create mode 100644 drivers/fpga/xrt/mgmt/fmgr-drv.c
>  create mode 100644 drivers/fpga/xrt/mgmt/fmgr.h
>  create mode 100644 drivers/fpga/xrt/mgmt/main-region.c
>
> diff --git a/drivers/fpga/xrt/mgmt/fmgr-drv.c b/drivers/fpga/xrt/mgmt/fmgr-drv.c
> new file mode 100644
> index 000000000000..a44d35ecdb60
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgmt/fmgr-drv.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FPGA Manager Support for Xilinx Alveo Management Function Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors: Sonal.Santan@xilinx.com
> + */
> +
> +#include <linux/cred.h>
> +#include <linux/efi.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/vmalloc.h>
> +
> +#include "xclbin-helper.h"
> +#include "xleaf.h"
> +#include "fmgr.h"
> +#include "xleaf/axigate.h"
> +#include "xleaf/icap.h"
> +#include "main-impl.h"
> +
> +struct xfpga_class {
> +	const struct platform_device *pdev;
> +	char                          name[64];
> +};
> +
> +/*
> + * xclbin download plumbing -- find the download subsystem, ICAP and
> + * pass the xclbin for heavy lifting
> + */
> +static int xmgmt_download_bitstream(struct platform_device *pdev,
> +				    const struct axlf *xclbin)
> +
> +{
> +	struct hw_icap_bit_header bit_header = { 0 };
> +	struct platform_device *icap_leaf = NULL;
> +	struct xrt_icap_ioctl_wr arg;
> +	char *bitstream = NULL;
> +	u64 bit_len;
> +	int ret;
> +
> +	ret = xrt_xclbin_get_section(xclbin, BITSTREAM, (void **)&bitstream, &bit_len);
> +	if (ret || !bitstream) {
!bitstream check is unneeded
> +		xrt_err(pdev, "bitstream not found");
> +		return -ENOENT;
> +	}
> +	ret = xrt_xclbin_parse_bitstream_header(bitstream,
> +						DMA_HWICAP_BITFILE_BUFFER_SIZE,
> +						&bit_header);
> +	if (ret) {
> +		ret = -EINVAL;
> +		xrt_err(pdev, "invalid bitstream header");
> +		goto done;
> +	}
> +	if (bit_header.header_length + bit_header.bitstream_length > bit_len) {
> +		ret = -EINVAL;
> +		xrt_err(pdev, "invalid bitstream length. header %d, bitstream %d, section len %lld",
> +			bit_header.header_length, bit_header.bitstream_length, bit_len);
> +		goto done;
> +	}
> +
> +	icap_leaf = xleaf_get_leaf_by_id(pdev, XRT_SUBDEV_ICAP, PLATFORM_DEVID_NONE);
> +	if (!icap_leaf) {
> +		ret = -ENODEV;
> +		xrt_err(pdev, "icap does not exist");
> +		xrt_xclbin_free_header(&bit_header);
> +		goto done;
> +	}
> +	arg.xiiw_bit_data = bitstream + bit_header.header_length;
> +	arg.xiiw_data_len = bit_header.bitstream_length;
> +	ret = xleaf_ioctl(icap_leaf, XRT_ICAP_WRITE, &arg);
> +	if (ret)
> +		xrt_err(pdev, "write bitstream failed, ret = %d", ret);
> +
> +	xrt_xclbin_free_header(&bit_header);
memory leak when something fails and goto done's
> +done:
previous general problem, use mutliple label in error handling blocks
> +	if (icap_leaf)
> +		xleaf_put_leaf(pdev, icap_leaf);
> +	vfree(bitstream);
> +
> +	return ret;
> +}
> +
> +/*
> + * There is no HW prep work we do here since we need the full
> + * xclbin for its sanity check.
> + */
> +static int xmgmt_pr_write_init(struct fpga_manager *mgr,
> +			       struct fpga_image_info *info,
> +			       const char *buf, size_t count)
> +{
> +	const struct axlf *bin = (const struct axlf *)buf;
> +	struct xfpga_class *obj = mgr->priv;
> +
> +	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> +		xrt_info(obj->pdev, "%s only supports partial reconfiguration\n", obj->name);
> +		return -EINVAL;
> +	}
> +
> +	if (count < sizeof(struct axlf))
> +		return -EINVAL;
> +
> +	if (count > bin->m_header.m_length)
> +		return -EINVAL;
> +
> +	xrt_info(obj->pdev, "Prepare download of xclbin %pUb of length %lld B",
> +		 &bin->m_header.uuid, bin->m_header.m_length);
> +
> +	return 0;
> +}
> +
> +/*
> + * The implementation requries full xclbin image before we can start
> + * programming the hardware via ICAP subsystem. Full image is required
The full image
> + * for checking the validity of xclbin and walking the sections to
> + * discover the bitstream.
> + */
> +static int xmgmt_pr_write(struct fpga_manager *mgr,
> +			  const char *buf, size_t count)
> +{
> +	const struct axlf *bin = (const struct axlf *)buf;
> +	struct xfpga_class *obj = mgr->priv;
> +
> +	if (bin->m_header.m_length != count)
> +		return -EINVAL;
> +
> +	return xmgmt_download_bitstream((void *)obj->pdev, bin);
> +}
> +
> +static int xmgmt_pr_write_complete(struct fpga_manager *mgr,
> +				   struct fpga_image_info *info)
> +{
> +	const struct axlf *bin = (const struct axlf *)info->buf;
> +	struct xfpga_class *obj = mgr->priv;
> +
> +	xrt_info(obj->pdev, "Finished download of xclbin %pUb",
> +		 &bin->m_header.uuid);
> +	return 0;
> +}
> +
> +static enum fpga_mgr_states xmgmt_pr_state(struct fpga_manager *mgr)
> +{
> +	return FPGA_MGR_STATE_UNKNOWN;
why just this state ?
> +}
> +
> +static const struct fpga_manager_ops xmgmt_pr_ops = {
> +	.initial_header_size = sizeof(struct axlf),
> +	.write_init = xmgmt_pr_write_init,
> +	.write = xmgmt_pr_write,
> +	.write_complete = xmgmt_pr_write_complete,
> +	.state = xmgmt_pr_state,
> +};
> +
> +struct fpga_manager *xmgmt_fmgr_probe(struct platform_device *pdev)
> +{
> +	struct xfpga_class *obj = devm_kzalloc(DEV(pdev), sizeof(struct xfpga_class),
> +					       GFP_KERNEL);
> +	struct fpga_manager *fmgr = NULL;
> +	int ret = 0;
> +
> +	if (!obj)
> +		return ERR_PTR(-ENOMEM);
> +
> +	snprintf(obj->name, sizeof(obj->name), "Xilinx Alveo FPGA Manager");
> +	obj->pdev = pdev;
> +	fmgr = fpga_mgr_create(&pdev->dev,
> +			       obj->name,
> +			       &xmgmt_pr_ops,
> +			       obj);
> +	if (!fmgr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = fpga_mgr_register(fmgr);
> +	if (ret) {
> +		fpga_mgr_free(fmgr);
> +		return ERR_PTR(ret);
> +	}
> +	return fmgr;
> +}
> +
> +int xmgmt_fmgr_remove(struct fpga_manager *fmgr)
> +{
> +	fpga_mgr_unregister(fmgr);
> +	return 0;
> +}
> diff --git a/drivers/fpga/xrt/mgmt/fmgr.h b/drivers/fpga/xrt/mgmt/fmgr.h
> new file mode 100644
> index 000000000000..e1fc033e2542
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgmt/fmgr.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Xilinx Alveo Management Function Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors: Sonal.Santan@xilinx.com
> + */
> +
> +#ifndef _XMGMT_FMGR_H_
> +#define _XMGMT_FMGR_H_
> +
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/mutex.h>
> +
> +#include <linux/xrt/xclbin.h>
> +
> +enum xfpga_sec_level {
> +	XFPGA_SEC_NONE = 0,
> +	XFPGA_SEC_DEDICATE,
> +	XFPGA_SEC_SYSTEM,
> +	XFPGA_SEC_MAX = XFPGA_SEC_SYSTEM,
> +};
This enum is not used, remove.
> +
> +struct fpga_manager *xmgmt_fmgr_probe(struct platform_device *pdev);
> +int xmgmt_fmgr_remove(struct fpga_manager *fmgr);
> +
> +#endif
> diff --git a/drivers/fpga/xrt/mgmt/main-region.c b/drivers/fpga/xrt/mgmt/main-region.c
> new file mode 100644
> index 000000000000..9779693fe7ae
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgmt/main-region.c
> @@ -0,0 +1,471 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FPGA Region Support for Xilinx Alveo Management Function Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + * Bulk of the code borrowed from XRT mgmt driver file, fmgr.c
> + *
> + * Authors: Lizhi.Hou@xilinx.com
> + */
> +
> +#include <linux/uuid.h>
> +#include <linux/fpga/fpga-bridge.h>
> +#include <linux/fpga/fpga-region.h>
> +#include "metadata.h"
> +#include "xleaf.h"
> +#include "xleaf/axigate.h"
> +#include "xclbin-helper.h"
> +#include "main-impl.h"
> +
> +struct xmgmt_bridge {
> +	struct platform_device *pdev;
> +	const char *axigate_name;

axigate ?

this element could just be 'name'

it seems like 'axigate' means 'bridge', why not use 'bridge' ?

> +};
> +
> +struct xmgmt_region {
> +	struct platform_device *pdev;
> +	struct fpga_region *fregion;
> +	uuid_t intf_uuid;
> +	struct fpga_bridge *fbridge;
> +	int grp_inst;
> +	uuid_t dep_uuid;
> +	struct list_head list;

clean up element names

fregion -> region

grp_inst -> group_instance

ect.

> +};
> +
> +struct xmgmt_region_match_arg {
> +	struct platform_device *pdev;
> +	uuid_t *uuids;
> +	u32 uuid_num;
> +};
> +
> +static int xmgmt_br_enable_set(struct fpga_bridge *bridge, bool enable)
> +{
> +	struct xmgmt_bridge *br_data = (struct xmgmt_bridge *)bridge->priv;
> +	struct platform_device *axigate_leaf;
> +	int rc;
> +
> +	axigate_leaf = xleaf_get_leaf_by_epname(br_data->pdev, br_data->axigate_name);
> +	if (!axigate_leaf) {
> +		xrt_err(br_data->pdev, "failed to get leaf %s",
> +			br_data->axigate_name);
> +		return -ENOENT;
> +	}
> +
> +	if (enable)
> +		rc = xleaf_ioctl(axigate_leaf, XRT_AXIGATE_FREE, NULL);
> +	else
> +		rc = xleaf_ioctl(axigate_leaf, XRT_AXIGATE_FREEZE, NULL);
> +
> +	if (rc) {
> +		xrt_err(br_data->pdev, "failed to %s gate %s, rc %d",
> +			(enable ? "free" : "freeze"), br_data->axigate_name,
> +			rc);
> +	}
> +
> +	xleaf_put_leaf(br_data->pdev, axigate_leaf);
> +
> +	return rc;
> +}
> +
> +const struct fpga_bridge_ops xmgmt_bridge_ops = {
> +	.enable_set = xmgmt_br_enable_set
> +};
> +
> +static void xmgmt_destroy_bridge(struct fpga_bridge *br)
> +{
> +	struct xmgmt_bridge *br_data = br->priv;
> +
> +	if (!br_data)
> +		return;
> +
> +	xrt_info(br_data->pdev, "destroy fpga bridge %s", br_data->axigate_name);
> +	fpga_bridge_unregister(br);
> +
> +	devm_kfree(DEV(br_data->pdev), br_data);
> +
> +	fpga_bridge_free(br);
> +}
> +
> +static struct fpga_bridge *xmgmt_create_bridge(struct platform_device *pdev,
> +					       char *dtb)
> +{
> +	struct xmgmt_bridge *br_data;
> +	struct fpga_bridge *br = NULL;
> +	const char *gate;
> +	int rc;
> +
> +	br_data = devm_kzalloc(DEV(pdev), sizeof(*br_data), GFP_KERNEL);
> +	if (!br_data)
> +		return NULL;
> +	br_data->pdev = pdev;
> +
> +	br_data->axigate_name = XRT_MD_NODE_GATE_ULP;
> +	rc = xrt_md_find_endpoint(&pdev->dev, dtb, XRT_MD_NODE_GATE_ULP,
> +				  NULL, &gate);
> +	if (rc) {
> +		br_data->axigate_name = XRT_MD_NODE_GATE_PLP;
> +		rc = xrt_md_find_endpoint(&pdev->dev, dtb, XRT_MD_NODE_GATE_PLP,
> +					  NULL, &gate);
> +	}
> +	if (rc) {
> +		xrt_err(pdev, "failed to get axigate, rc %d", rc);
> +		goto failed;
> +	}
> +
> +	br = fpga_bridge_create(DEV(pdev), br_data->axigate_name,
> +				&xmgmt_bridge_ops, br_data);
> +	if (!br) {
> +		xrt_err(pdev, "failed to create bridge");
> +		goto failed;
> +	}
> +
> +	rc = fpga_bridge_register(br);
> +	if (rc) {
> +		xrt_err(pdev, "failed to register bridge, rc %d", rc);
> +		goto failed;
> +	}
> +
> +	xrt_info(pdev, "created fpga bridge %s", br_data->axigate_name);
> +
> +	return br;
> +
> +failed:
> +	if (br)
> +		fpga_bridge_free(br);
> +	if (br_data)
> +		devm_kfree(DEV(pdev), br_data);
> +
> +	return NULL;
> +}
> +
> +static void xmgmt_destroy_region(struct fpga_region *re)

re, to me means regular expression.

can you use 'region' instead ?

> +{
> +	struct xmgmt_region *r_data = re->priv;
> +
> +	xrt_info(r_data->pdev, "destroy fpga region %llx%llx",
need a sperator here ? between %llx%llx
> +		 re->compat_id->id_l, re->compat_id->id_h);
> +
> +	fpga_region_unregister(re);
> +
> +	if (r_data->grp_inst > 0)
> +		xleaf_destroy_group(r_data->pdev, r_data->grp_inst);
> +
> +	if (r_data->fbridge)
> +		xmgmt_destroy_bridge(r_data->fbridge);
> +
> +	if (r_data->fregion->info) {
> +		fpga_image_info_free(r_data->fregion->info);
> +		r_data->fregion->info = NULL;
> +	}
> +
> +	fpga_region_free(re);
> +
> +	devm_kfree(DEV(r_data->pdev), r_data);
> +}
> +
> +static int xmgmt_region_match(struct device *dev, const void *data)
> +{
> +	const struct xmgmt_region_match_arg *arg = data;
> +	const struct fpga_region *match_re;
> +	int i;
> +
> +	if (dev->parent != &arg->pdev->dev)
> +		return false;
> +
> +	match_re = to_fpga_region(dev);
> +	/*
> +	 * The device tree provides both parent and child uuids for an
> +	 * xclbin in one array. Here we try both uuids to see if it matches
> +	 * with target region's compat_id. Strictly speaking we should
> +	 * only match xclbin's parent uuid with target region's compat_id
> +	 * but given the uuids by design are unique comparing with both
> +	 * does not hurt.
> +	 */
> +	for (i = 0; i < arg->uuid_num; i++) {
> +		if (!memcmp(match_re->compat_id, &arg->uuids[i],
> +			    sizeof(*match_re->compat_id)))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int xmgmt_region_match_base(struct device *dev, const void *data)
> +{
> +	const struct xmgmt_region_match_arg *arg = data;
> +	const struct fpga_region *match_re;
> +	const struct xmgmt_region *r_data;
> +
> +	if (dev->parent != &arg->pdev->dev)
> +		return false;
> +
> +	match_re = to_fpga_region(dev);
me getting confused thinking match_re is 'match regular expression'
> +	r_data = match_re->priv;
> +	if (uuid_is_null(&r_data->dep_uuid))
> +		return true;
> +
> +	return false;
> +}
> +
> +static int xmgmt_region_match_by_depuuid(struct device *dev, const void *data)

what is a dep uuid ?

should add a '_' so function name is xmgmt_region_match_by_dep_uuid()

this is quite long.

> +{
> +	const struct xmgmt_region_match_arg *arg = data;
> +	const struct fpga_region *match_re;
> +	const struct xmgmt_region *r_data;
> +
> +	if (dev->parent != &arg->pdev->dev)
> +		return false;
> +
> +	match_re = to_fpga_region(dev);
> +	r_data = match_re->priv;
> +	if (!memcmp(&r_data->dep_uuid, arg->uuids, sizeof(uuid_t)))

arg->uuids is an array

arg->uuid_num is its extent.

should be a loop or check on uuid_num == 1 or both.

> +		return true;
> +
> +	return false;
> +}
> +
> +static void xmgmt_region_cleanup(struct fpga_region *re)
> +{
> +	struct xmgmt_region *r_data = re->priv, *temp;
> +	struct platform_device *pdev = r_data->pdev;
> +	struct fpga_region *match_re = NULL;
> +	struct device *start_dev = NULL;
> +	struct xmgmt_region_match_arg arg;
> +	LIST_HEAD(free_list);
> +
> +	list_add_tail(&r_data->list, &free_list);
> +	arg.pdev = pdev;
> +	arg.uuid_num = 1;
> +
> +	while (!r_data) {
> +		arg.uuids = (uuid_t *)r_data->fregion->compat_id;
> +		match_re = fpga_region_class_find(start_dev, &arg,
> +						  xmgmt_region_match_by_depuuid);
> +		if (match_re) {
> +			r_data = match_re->priv;

This setting of r_data and continuing is strange, add a comment.

or if you intend to do a pair of operations, do the pair within the if block and remove the strangeness.

> +			list_add_tail(&r_data->list, &free_list);
> +			start_dev = &match_re->dev;
> +			put_device(&match_re->dev);
> +			continue;
> +		}
> +
> +		r_data = list_is_last(&r_data->list, &free_list) ? NULL :
> +			list_next_entry(r_data, list);
> +		start_dev = NULL;
> +	}
> +
> +	list_for_each_entry_safe_reverse(r_data, temp, &free_list, list) {
> +		if (list_is_first(&r_data->list, &free_list)) {
> +			if (r_data->grp_inst > 0) {
> +				xleaf_destroy_group(pdev, r_data->grp_inst);
> +				r_data->grp_inst = -1;
> +			}
> +			if (r_data->fregion->info) {
> +				fpga_image_info_free(r_data->fregion->info);
> +				r_data->fregion->info = NULL;
> +			}
> +			continue;
add a comment, why is a continue needed here ?
> +		}
> +		xmgmt_destroy_region(r_data->fregion);
> +	}
> +}
> +
> +void xmgmt_region_cleanup_all(struct platform_device *pdev)
> +{
> +	struct fpga_region *base_re;
> +	struct xmgmt_region_match_arg arg;
> +
> +	arg.pdev = pdev;
> +
> +	for (base_re = fpga_region_class_find(NULL, &arg, xmgmt_region_match_base);
> +	    base_re;
> +	    base_re = fpga_region_class_find(NULL, &arg, xmgmt_region_match_base)) {

convert to a while

while (base_region = ... ) {

> +		put_device(&base_re->dev);
> +
> +		xmgmt_region_cleanup(base_re);
> +		xmgmt_destroy_region(base_re);
> +	}
> +}
> +
> +/*
> + * Program a given region with given xclbin image. Bring up the subdevs and the
Program a region with a xclbin image.
> + * group object to contain the subdevs.
> + */
> +static int xmgmt_region_program(struct fpga_region *re, const void *xclbin, char *dtb)
> +{
> +	struct xmgmt_region *r_data = re->priv;
> +	struct platform_device *pdev = r_data->pdev;
> +	struct fpga_image_info *info;
> +	const struct axlf *xclbin_obj = xclbin;
> +	int rc;
> +
> +	info = fpga_image_info_alloc(&pdev->dev);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->buf = xclbin;
> +	info->count = xclbin_obj->m_header.m_length;
> +	info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
> +	re->info = info;
> +	rc = fpga_region_program_fpga(re);
> +	if (rc) {
> +		xrt_err(pdev, "programming xclbin failed, rc %d", rc);
> +		return rc;
> +	}
free info ?
> +
> +	/* free bridges to allow reprogram */
> +	if (re->get_bridges)
> +		fpga_bridges_put(&re->bridge_list);
> +
> +	/*
> +	 * Next bringup the subdevs for this region which will be managed by
> +	 * its own group object.
> +	 */
> +	r_data->grp_inst = xleaf_create_group(pdev, dtb);
> +	if (r_data->grp_inst < 0) {
> +		xrt_err(pdev, "failed to create group, rc %d",
> +			r_data->grp_inst);
> +		rc = r_data->grp_inst;
> +		return rc;
> +	}
> +
> +	rc = xleaf_wait_for_group_bringup(pdev);
> +	if (rc)
> +		xrt_err(pdev, "group bringup failed, rc %d", rc);
failed but no error handling, shouldn't the leaves and group be torn down ?
> +	return rc;
> +}
> +
> +static int xmgmt_get_bridges(struct fpga_region *re)
> +{
> +	struct xmgmt_region *r_data = re->priv;
> +	struct device *dev = &r_data->pdev->dev;
> +
> +	return fpga_bridge_get_to_list(dev, re->info, &re->bridge_list);
> +}
> +
> +/*
> + * Program/create FPGA regions based on input xclbin file. This is key function
> + * stitching the flow together:
'This is ' .. sentence does not make sense, but is not needed drop it.
>  
> + * 1. Identify a matching existing region for this xclbin
> + * 2. Tear down any previous objects for the found region
> + * 3. Program this region with input xclbin
> + * 4. Iterate over this region's interface uuids to determine if it defines any
> + *    child region. Create fpga_region for the child region.
> + */
> +int xmgmt_process_xclbin(struct platform_device *pdev,
> +			 struct fpga_manager *fmgr,
> +			 const struct axlf *xclbin,
> +			 enum provider_kind kind)
> +{
> +	struct fpga_region *re, *compat_re = NULL;
> +	struct xmgmt_region_match_arg arg;
should initialize to { 0 }
> +	struct xmgmt_region *r_data;
> +	char *dtb = NULL;
> +	int rc, i;
> +
> +	rc = xrt_xclbin_get_metadata(DEV(pdev), xclbin, &dtb);
> +	if (rc) {
> +		xrt_err(pdev, "failed to get dtb: %d", rc);
> +		goto failed;
> +	}
> +
> +	xrt_md_get_intf_uuids(DEV(pdev), dtb, &arg.uuid_num, NULL);
should also check return and return that error code, it isn't always -EINVAL
> +	if (arg.uuid_num == 0) {
> +		xrt_err(pdev, "failed to get intf uuid");
> +		rc = -EINVAL;
> +		goto failed;
> +	}
> +	arg.uuids = vzalloc(sizeof(uuid_t) * arg.uuid_num);
> +	if (!arg.uuids) {
> +		rc = -ENOMEM;
> +		goto failed;
> +	}
> +	arg.pdev = pdev;
> +
> +	xrt_md_get_intf_uuids(DEV(pdev), dtb, &arg.uuid_num, arg.uuids);
This can still fail, check this return and check the expected num of uuid's has not changed.
> +
> +	/* if this is not base firmware, search for a compatible region */
> +	if (kind != XMGMT_BLP) {
> +		compat_re = fpga_region_class_find(NULL, &arg,
> +						   xmgmt_region_match);
> +		if (!compat_re) {
> +			xrt_err(pdev, "failed to get compatible region");
> +			rc = -ENOENT;
> +			goto failed;
> +		}
> +
> +		xmgmt_region_cleanup(compat_re);
> +
> +		rc = xmgmt_region_program(compat_re, xclbin, dtb);
> +		if (rc) {
> +			xrt_err(pdev, "failed to program region");
> +			goto failed;
> +		}
> +	}
> +
> +	/* create all the new regions contained in this xclbin */
> +	for (i = 0; i < arg.uuid_num; i++) {
> +		if (compat_re && !memcmp(compat_re->compat_id, &arg.uuids[i],
> +					 sizeof(*compat_re->compat_id)))
> +			/* region for this interface already exists */
> +			continue;
> +		re = fpga_region_create(DEV(pdev), fmgr, xmgmt_get_bridges);
> +		if (!re) {
> +			xrt_err(pdev, "failed to create fpga region");
> +			rc = -EFAULT;
> +			goto failed;
> +		}
> +		r_data = devm_kzalloc(DEV(pdev), sizeof(*r_data), GFP_KERNEL);
> +		if (!r_data) {
> +			rc = -ENOMEM;
> +			fpga_region_free(re);
> +			goto failed;

Failed in a loop but no cleanup of previous iterations.

Tom

> +		}
> +		r_data->pdev = pdev;
> +		r_data->fregion = re;
> +		r_data->grp_inst = -1;
> +		memcpy(&r_data->intf_uuid, &arg.uuids[i],
> +		       sizeof(r_data->intf_uuid));
> +		if (compat_re) {
> +			memcpy(&r_data->dep_uuid, compat_re->compat_id,
> +			       sizeof(r_data->intf_uuid));
> +		}
> +		r_data->fbridge = xmgmt_create_bridge(pdev, dtb);
> +		if (!r_data->fbridge) {
> +			xrt_err(pdev, "failed to create fpga bridge");
> +			rc = -EFAULT;
> +			devm_kfree(DEV(pdev), r_data);
> +			fpga_region_free(re);
> +			goto failed;
> +		}
> +
> +		re->compat_id = (struct fpga_compat_id *)&r_data->intf_uuid;
> +		re->priv = r_data;
> +
> +		rc = fpga_region_register(re);
> +		if (rc) {
> +			xrt_err(pdev, "failed to register fpga region");
> +			xmgmt_destroy_bridge(r_data->fbridge);
> +			fpga_region_free(re);
> +			devm_kfree(DEV(pdev), r_data);
> +			goto failed;
> +		}
> +
> +		xrt_info(pdev, "created fpga region %llx%llx",
> +			 re->compat_id->id_l, re->compat_id->id_h);
> +	}
> +
> +failed:
> +	if (compat_re)
> +		put_device(&compat_re->dev);
> +
> +	if (rc) {
> +		if (compat_re)
> +			xmgmt_region_cleanup(compat_re);
> +	}
> +
> +	if (dtb)
> +		vfree(dtb);
> +
> +	return rc;
> +}

