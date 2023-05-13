Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DA1701525
	for <lists+linux-fpga@lfdr.de>; Sat, 13 May 2023 09:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjEMHoe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 13 May 2023 03:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjEMHoY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 13 May 2023 03:44:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8D5196;
        Sat, 13 May 2023 00:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683963862; x=1715499862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=klEzGPXP/XOg3yILChn5snrX8XWSyciy43aGkqqQ7KY=;
  b=WaHK0RkmX9yyHL0uc+7PUJ3LpIR+Jd1UOEdbVmuj9EtRC3iKxN+eS+CL
   LnvMZf28CmoZO1vvl6eG+x9Ln77K3btGhNNHgEhuCUoXZOD2hU5SZMCjG
   gSmaf/lRb+KSXhkgfs96UZ1EKQq1iFk8q5Q7Dlb0bOjd/0Xqeq5bDq/Bf
   zMAytRru5qCRaJZ799BWHYTck3WRAEpBnFuP6jct23K15j3Q6l0LDO2y2
   2Rk9vqZq3tOpRthKPRAow6BXcxY3cyJCOJ5pCOiOJTSOXRC+R4lGcvSwQ
   exBlOscs94/WKtNo6jj4oDMtQ+vB+0Q0GWkX2TZ9CuvWZFiE1aYF5RV3o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="349776038"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="349776038"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 00:44:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="770042084"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="770042084"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 13 May 2023 00:44:19 -0700
Date:   Sat, 13 May 2023 23:44:19 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/4] fpga: add fake FPGA manager
Message-ID: <ZF+wU7tLO4m4EZbH@yilunxu-OptiPlex-7050>
References: <20230511141922.437328-1-marpagan@redhat.com>
 <20230511141922.437328-2-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511141922.437328-2-marpagan@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-11 at 16:19:19 +0200, Marco Pagani wrote:
> Add fake FPGA manager platform driver with support functions. This module
> is part of the KUnit tests for the FPGA subsystem.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fake-fpga-mgr.c | 271 +++++++++++++++++++++++++++++
>  drivers/fpga/tests/fake-fpga-mgr.h |  53 ++++++
>  2 files changed, 324 insertions(+)
>  create mode 100644 drivers/fpga/tests/fake-fpga-mgr.c
>  create mode 100644 drivers/fpga/tests/fake-fpga-mgr.h
> 
> diff --git a/drivers/fpga/tests/fake-fpga-mgr.c b/drivers/fpga/tests/fake-fpga-mgr.c
> new file mode 100644
> index 000000000000..1e994db10159
> --- /dev/null
> +++ b/drivers/fpga/tests/fake-fpga-mgr.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the fake FPGA manager
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/fpga/fpga-mgr.h>
> +
> +#include "fake-fpga-mgr.h"
> +
> +#define FAKE_FPGA_MGR_DEV_NAME	"fake_fpga_mgr"
> +
> +struct fake_mgr_pdata {
> +	struct kunit *test;
> +	struct fake_fpga_mgr_stats *stats;
> +};
> +
> +struct fake_mgr_priv {
> +	int seq_num;
> +	struct fake_mgr_pdata *pdata;
> +};
> +
> +static bool check_header(struct kunit *test, const char *buf, size_t count)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < count; i++)
> +		if (buf[i] != TEST_HEADER_MAGIC)
> +			return false;
> +
> +	return true;
> +}
> +
> +static enum fpga_mgr_states op_state(struct fpga_manager *mgr)
> +{
> +	struct fake_mgr_priv *priv;
> +
> +	priv = mgr->priv;
> +
> +	kunit_info(priv->pdata->test, "Fake FPGA manager: state\n");
> +
> +	return mgr->state;
> +}
> +
> +static u64 op_status(struct fpga_manager *mgr)
> +{
> +	struct fake_mgr_priv *priv;
> +
> +	priv = mgr->priv;
> +
> +	kunit_info(priv->pdata->test, "Fake FPGA manager: status\n");
> +
> +	return 0;
> +}
> +
> +static int op_parse_header(struct fpga_manager *mgr, struct fpga_image_info *info,
> +			   const char *buf, size_t count)
> +{
> +	struct fake_mgr_priv *priv;
> +
> +	priv = mgr->priv;
> +
> +	/* Set header_size and data_size as expected */
> +	info->header_size = TEST_HEADER_SIZE;
> +	info->data_size = info->count - TEST_HEADER_SIZE;
> +
> +	priv->pdata->stats->header_done = check_header(priv->pdata->test, buf,
> +						       info->header_size);
> +	priv->pdata->stats->op_parse_header_state = mgr->state;
> +	priv->pdata->stats->op_parse_header_seq = priv->seq_num++;
> +
> +	kunit_info(priv->pdata->test, "Fake FPGA manager: parse_header\n");
> +
> +	return 0;
> +}
> +
> +static int op_write_init(struct fpga_manager *mgr, struct fpga_image_info *info,
> +			 const char *buf, size_t count)
> +{
> +	struct fake_mgr_priv *priv;
> +
> +	priv = mgr->priv;
> +
> +	priv->pdata->stats->op_write_init_state = mgr->state;
> +	priv->pdata->stats->op_write_init_seq = priv->seq_num++;
> +
> +	kunit_info(priv->pdata->test, "Fake FPGA manager: write_init\n");
> +
> +	return 0;
> +}
> +
> +static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
> +{
> +	struct fake_mgr_priv *priv;
> +
> +	priv = mgr->priv;
> +
> +	priv->pdata->stats->op_write_state = mgr->state;
> +	priv->pdata->stats->op_write_seq = priv->seq_num++;
> +
> +	kunit_info(priv->pdata->test, "Fake FPGA manager: write\n");
> +
> +	return 0;
> +}
> +
> +static int op_write_sg(struct fpga_manager *mgr, struct sg_table *sgt)
> +{
> +	struct fake_mgr_priv *priv;
> +
> +	priv = mgr->priv;
> +
> +	priv->pdata->stats->op_write_state = mgr->state;
> +	priv->pdata->stats->op_write_seq = priv->seq_num++;
> +
> +	kunit_info(priv->pdata->test, "Fake FPGA manager: write_sg\n");
> +
> +	return 0;
> +}
> +
> +static int op_write_complete(struct fpga_manager *mgr, struct fpga_image_info *info)
> +{
> +	struct fake_mgr_priv *priv;
> +
> +	priv = mgr->priv;
> +
> +	priv->pdata->stats->op_write_complete_state = mgr->state;
> +	priv->pdata->stats->op_write_complete_seq = priv->seq_num++;
> +	priv->pdata->stats->prog_count++;
> +
> +	kunit_info(priv->pdata->test, "Fake FPGA manager: write_complete\n");
> +
> +	return 0;
> +}
> +
> +static void op_fpga_remove(struct fpga_manager *mgr)
> +{
> +	struct fake_mgr_priv *priv;
> +
> +	priv = mgr->priv;
> +
> +	kunit_info(priv->pdata->test, "Fake FPGA manager: remove\n");
> +}
> +
> +static const struct fpga_manager_ops fake_fpga_mgr_ops = {
> +	.skip_header = false,
> +	.state = op_state,
> +	.status = op_status,
> +	.parse_header = op_parse_header,
> +	.write_init = op_write_init,
> +	.write = op_write,
> +	.write_sg = op_write_sg,
> +	.write_complete = op_write_complete,
> +	.fpga_remove = op_fpga_remove,
> +};
> +
> +/**
> + * fake_fpga_mgr_register() - register a fake FPGA manager.
> + * @test: KUnit test context object.
> + * @mgr_ctx: fake FPGA manager context data structure.
> + *
> + * Return: pointer to a new fake FPGA manager on success, an ERR_PTR()
> + * encoded error code on failure.
> + */
> +struct fake_fpga_mgr *
> +fake_fpga_mgr_register(struct kunit *test, struct device *parent)
> +{
> +	struct fake_fpga_mgr *mgr_ctx;
> +	struct fake_mgr_pdata pdata;
> +	int ret;
> +
> +	mgr_ctx = kunit_kzalloc(test, sizeof(*mgr_ctx), GFP_KERNEL);
> +	if (!mgr_ctx) {
> +		ret = -ENOMEM;
> +		goto err_mem;
> +	}
> +
> +	mgr_ctx->pdev = platform_device_alloc(FAKE_FPGA_MGR_DEV_NAME,
> +					      PLATFORM_DEVID_AUTO);
> +	if (!mgr_ctx->pdev) {
> +		kunit_err(test, "Fake FPGA manager device allocation failed\n");
> +		ret = -ENOMEM;
> +		goto err_mem;
> +	}
> +
> +	pdata.test = test;
> +	pdata.stats = &mgr_ctx->stats;
> +	platform_device_add_data(mgr_ctx->pdev, &pdata, sizeof(pdata));
> +
> +	mgr_ctx->pdev->dev.parent = parent;
> +	ret = platform_device_add(mgr_ctx->pdev);
> +	if (ret) {
> +		kunit_err(test, "Fake FPGA manager device add failed\n");
> +		goto err_pdev;
> +	}

Is it possible also move this function in fpga-test?

> +
> +	mgr_ctx->mgr = platform_get_drvdata(mgr_ctx->pdev);

If moved out, platform_get_drvdata() from outside the driver is not a
good idea, maybe use class_find_device() to find the mgr out.

> +
> +	kunit_info(test, "Fake FPGA manager registered\n");
> +
> +	return mgr_ctx;
> +
> +err_pdev:
> +	platform_device_put(mgr_ctx->pdev);
> +err_mem:
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_mgr_register);
> +
> +/**
> + * fake_fpga_mgr_unregister() - unregister a fake FPGA manager.
> + * @mgr_ctx: fake FPGA manager context data structure.
> + */
> +void fake_fpga_mgr_unregister(struct fake_fpga_mgr *mgr_ctx)
> +{
> +	struct fake_mgr_priv *priv;
> +	struct kunit *test;
> +
> +	if (!mgr_ctx)
> +		return;
> +
> +	priv = mgr_ctx->mgr->priv;
> +	test = priv->pdata->test;
> +
> +	platform_device_unregister(mgr_ctx->pdev);
> +
> +	kunit_info(test, "Fake FPGA manager unregistered\n");
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_mgr_unregister);
> +
> +static int fake_fpga_mgr_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct fake_mgr_pdata *pdata;
> +	struct fpga_manager *mgr;
> +	struct fake_mgr_priv *priv;
> +
> +	dev = &pdev->dev;
> +	pdata = dev_get_platdata(dev);
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pdata = pdata;
> +
> +	mgr = devm_fpga_mgr_register(dev, "Fake FPGA Manager",
> +				     &fake_fpga_mgr_ops, priv);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
> +
> +	platform_set_drvdata(pdev, mgr);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver fake_fpga_mgr_drv = {
> +	.driver = {
> +		.name = FAKE_FPGA_MGR_DEV_NAME
> +	},
> +	.probe = fake_fpga_mgr_probe,
> +};
> +
> +module_platform_driver(fake_fpga_mgr_drv);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/fpga/tests/fake-fpga-mgr.h b/drivers/fpga/tests/fake-fpga-mgr.h
> new file mode 100644
> index 000000000000..282c20d8e40c
> --- /dev/null
> +++ b/drivers/fpga/tests/fake-fpga-mgr.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for the fake FPGA manager
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#ifndef __FPGA_FAKE_MGR_H
> +#define __FPGA_FAKE_MGR_H
> +
> +#include <linux/types.h>
> +#include <linux/platform_device.h>
> +#include <kunit/test.h>
> +#include <linux/fpga/fpga-mgr.h>
> +
> +#define FPGA_IMG_BLOCK		1024
> +#define TEST_HEADER_MAGIC	0x3f
> +#define TEST_HEADER_SIZE	FPGA_IMG_BLOCK
> +
> +struct fake_fpga_mgr_stats {
> +	u32 prog_count;
> +	bool header_done;
> +	u32 op_parse_header_seq;
> +	u32 op_write_init_seq;
> +	u32 op_write_seq;
> +	u32 op_write_complete_seq;
> +	enum fpga_mgr_states op_parse_header_state;
> +	enum fpga_mgr_states op_write_init_state;
> +	enum fpga_mgr_states op_write_state;
> +	enum fpga_mgr_states op_write_complete_state;
> +};
> +
> +/**
> + * struct fake_fpga_mgr - fake FPGA manager context data structure
> + *
> + * @mgr: FPGA manager.
> + * @pdev: platform device of the FPGA manager.
> + * @stats: info from the low level driver.
> + */
> +struct fake_fpga_mgr {
> +	struct fpga_manager *mgr;
> +	struct platform_device *pdev;
> +	struct fake_fpga_mgr_stats stats;
> +};
> +
> +struct fake_fpga_mgr *
> +fake_fpga_mgr_register(struct kunit *test, struct device *parent);
> +
> +void fake_fpga_mgr_unregister(struct fake_fpga_mgr *mgr_ctx);
> +
> +#endif /* __FPGA_FAKE_MGR_H */
> -- 
> 2.40.1
> 
