Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AF665955F
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Dec 2022 07:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiL3GUi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Dec 2022 01:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiL3GUg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Dec 2022 01:20:36 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D4113E1E;
        Thu, 29 Dec 2022 22:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672381235; x=1703917235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2T72n9Mj+b8Z//iwPA920IO8VKwHu8ghTPBx1sisCog=;
  b=awie7eFi3FVAgp4w9Y9gCtt3AM5+KZdffeyJaJ93qI3AQx+5HUizJK8i
   IIYAwL5OKWrT20DBuq0mMvgHazaa4xw3cgCeRUfdbM2wJa49Xtwnu/G38
   m+EUxEKe4PczEFAW7Oi649UnC5XDRAMcAJyO4oqopUThMkFyGyV5gdeee
   yEA/eCjLRWIDM8Ly2JOu8iK3Yr616yDvI5U0idpR/8qv5jCIx85d+4nIh
   Rm21LKolG+ip4uYKf1J1H8T1xoNOPeuW+/Mt+WOApKQPZ+4C0YkAylS55
   o9stYi06CUYx6udkGdSt17WlYzN/WaC204n+0hLf2JNsj1qNLhAQm6ejb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="304667735"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="304667735"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 22:20:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="686182848"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="686182848"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2022 22:20:31 -0800
Date:   Fri, 30 Dec 2022 14:10:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/10] fpga: m10bmc-sec: Add support for N6000
Message-ID: <Y66A0Au6GjaQwTBJ@yilunxu-OptiPlex-7050>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
 <20221226175849.13056-11-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221226175849.13056-11-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-26 at 19:58:49 +0200, Ilpo Järvinen wrote:
> Add support for PMCI-based flash access path and N6000 sec update
> support. Access to flash staging area is different for N6000 from that
> of the SPI interfaced counterparts.
> 
> Introduce intel_m10bmc_flash_bulk_ops to allow interface specific
> differentiations for the flash access path for sec update and make
> m10bmc_sec_read/write() in sec update driver to use the new operations.
> 
> If a failure is detected while altering the flash MUX, it seems safer
> to try to set it back and doesn't seem harmful. Likely there are enough
> troubles in that case anyway so setting it back fails too (which is
> harmless sans the small extra delay) or just confirms that the value
> wasn't changed.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c |  65 ++++++++++-
>  drivers/mfd/intel-m10-bmc-pmci.c        | 145 ++++++++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h       |  14 +++
>  3 files changed, 223 insertions(+), 1 deletion(-)
