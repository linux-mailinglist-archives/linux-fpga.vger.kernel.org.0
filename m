Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8272CB322
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Dec 2020 04:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgLBDFs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Dec 2020 22:05:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:37973 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgLBDFr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 1 Dec 2020 22:05:47 -0500
IronPort-SDR: KpvNgF/FhCjUUVsWF7bHwJH9cEsWGgKKeEPfiPs0vXnfZ4oonIep0YuWDzfe0uAB8+xId8lwMN
 8+zSYgf8A1yA==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="173041944"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="173041944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 19:04:57 -0800
IronPort-SDR: GBCM2P7tgqOK8o7TvMfXOZ+BefCxHQCn7xcH9OAKNbNSwNraesLQiiwx2iBK7mq5DGaa2Aq8Lp
 uCgOvMAd1pfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="539490975"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 01 Dec 2020 19:04:55 -0800
Date:   Wed, 2 Dec 2020 11:00:26 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Sonal Santan <sonal.santan@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, lizhih@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org
Subject: Re: [PATCH Xilinx Alveo 7/8] fpga: xrt: Alveo management physical
 function driver
Message-ID: <20201202030026.GD22103@yilunxu-OptiPlex-7050>
References: <20201129000040.24777-1-sonals@xilinx.com>
 <20201129000040.24777-8-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129000040.24777-8-sonals@xilinx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> +static int xmgmt_main_event_cb(struct platform_device *pdev,
> +	enum xrt_events evt, void *arg)
> +{
> +	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
> +	struct xrt_event_arg_subdev *esd = (struct xrt_event_arg_subdev *)arg;
> +	enum xrt_subdev_id id;
> +	int instance;
> +	size_t fwlen;
> +
> +	switch (evt) {
> +	case XRT_EVENT_POST_CREATION: {
> +		id = esd->xevt_subdev_id;
> +		instance = esd->xevt_subdev_instance;
> +		xrt_info(pdev, "processing event %d for (%d, %d)",
> +			evt, id, instance);
> +
> +		if (id == XRT_SUBDEV_GPIO)
> +			xmm->gpio_ready = true;
> +		else if (id == XRT_SUBDEV_QSPI)
> +			xmm->flash_ready = true;
> +		else
> +			BUG_ON(1);
> +
> +		if (xmm->gpio_ready && xmm->flash_ready) {
> +			int rc;
> +
> +			rc = load_firmware_from_disk(pdev, &xmm->firmware_blp,
> +				&fwlen);
> +			if (rc != 0) {
> +				rc = load_firmware_from_flash(pdev,
> +					&xmm->firmware_blp, &fwlen);

I'm curious that before the shell metadata is loaded, how the QSPI
subdev is enumerated and get to work? The QSPI DT info itself is
stored in metadata, is it?

I didn't find the creation of leaf platform devices, maybe I can find
the answer in the missing Patch #5?

Thanks,
Yilun

> +			}
> +			if (rc == 0 && is_valid_firmware(pdev,
> +			    xmm->firmware_blp, fwlen))
> +				(void) xmgmt_create_blp(xmm);
> +			else
> +				xrt_err(pdev,
> +					"failed to find firmware, giving up");
> +			xmm->evt_hdl = NULL;
> +		}
> +		break;
> +	}
