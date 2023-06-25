Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18273CEFD
	for <lists+linux-fpga@lfdr.de>; Sun, 25 Jun 2023 09:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFYHel (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Jun 2023 03:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFYHej (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Jun 2023 03:34:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91A11B5;
        Sun, 25 Jun 2023 00:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687678478; x=1719214478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MPQi2c2fpXlw+ZthqxGOQmVWtzdUzfcjBa7myYXUx6I=;
  b=Or2aif5AXuBLAgAHslkbvQ2ZBG50DzI21LNMFtXRE5dWptF8p689Asrq
   DE90otBXatAPlV3pxYD4IbRSY8dzgV2n23dV/3lQA3e64hz2DoT+YS5nl
   1mGucjPq9MDMFJ//8TzCTbYFJX+l1T7beo5kPrX9JNKRaNRgXx4E66Y9C
   iSQJ+6DUGoQSiRPUmrW6eLJk/7atcUnCjCH3FB/+NAnnp0zlEsZuYfJFI
   jd+Idd72JHTRiIlQHEVTLIPXhOV3ObuDPsU3Dl3EuCN4k/qaZip/sZ6AJ
   bAwaq0qpfJcCrHMj70pJbjRLNMKctuFGRFj6HS8bPRNT0akVkACkK+iIk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="340628223"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="340628223"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 00:34:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="745427810"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="745427810"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 25 Jun 2023 00:34:36 -0700
Date:   Sun, 25 Jun 2023 15:33:29 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v7 2/4] fpga: add an initial KUnit suite for the FPGA
 Bridge
Message-ID: <ZJftyXGY5TbEqPqk@yilunxu-OptiPlex-7050>
References: <20230616154405.220502-1-marpagan@redhat.com>
 <20230616154405.220502-3-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616154405.220502-3-marpagan@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-16 at 17:44:03 +0200, Marco Pagani wrote:
> The suite tests the basic behaviors of the FPGA Bridge including
> the functions that operate on a list of Bridges.
                                          ^
why uppercase?

> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fpga-bridge-test.c | 175 ++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 drivers/fpga/tests/fpga-bridge-test.c
> 
> diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
> new file mode 100644
> index 000000000000..fce67ac59a7c
> --- /dev/null
> +++ b/drivers/fpga/tests/fpga-bridge-test.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the FPGA Bridge
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <kunit/test.h>
> +#include <linux/fpga/fpga-bridge.h>

alphabetical order please.

Others LGTM.
Acked-by: Xu Yilun <yilun.xu@intel.com>
