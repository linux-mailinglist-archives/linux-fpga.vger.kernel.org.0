Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D03967E1E3
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 11:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjA0Ki0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 05:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjA0KiZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 05:38:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4D07DB8;
        Fri, 27 Jan 2023 02:38:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA2C61AA9;
        Fri, 27 Jan 2023 10:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C968C433D2;
        Fri, 27 Jan 2023 10:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674815887;
        bh=pJrHcASI3Y1zggOjix6zBG1wcsyIXmNxAj0ftpm8R6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFplpJvMdGh9pjBTPOrT0VQWH4e6jiRz2tzsVTD3tyuwbLKz2aKIUiLY4iRnMbIX1
         aBMix64/VvjoalzZdgU2W0hxO2qNSHIeCfymf8VdN9Vz+bLtgczdwtsrAJ2TGiJL/O
         wnZ4q9XY2Kw8wGYY1O+DclE5QpYdFacZViPG/yxNWUfs1GSxsibGTakPrLRfdDleM9
         p73D7mDyHFQe6PJoGX4DJesQABAILLOVjM0PD56tbe4VutkxD32k89KJ06H/YeKxuL
         HwPMQeQIhDW5q/izZb22cLztb6WX73gl2fGIGRifdu9EeXQTJJH6aWedLnzwkaUQoX
         sF2KHX0ivZD5Q==
Date:   Fri, 27 Jan 2023 10:38:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/11] mfd: intel-m10-bmc: Prefix register defines
 with M10BMC_N3000
Message-ID: <Y9OpiT8tyXPWbvdK@google.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <20230116100845.6153-8-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116100845.6153-8-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 16 Jan 2023, Ilpo Järvinen wrote:

> Prefix the M10BMC defines register defines with M10BMC_N3000 to make it
> more obvious these are related to some board type. All current
> non-N3000 board types have the same layout so they'll be reused. The
> less generic makes it more obvious they're not meant for the
> generic/interface agnostic code.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/mfd/intel-m10-bmc-core.c  | 14 +++----
>  drivers/mfd/intel-m10-bmc-spi.c   | 52 ++++++++++++------------
>  include/linux/mfd/intel-m10-bmc.h | 66 +++++++++++++++----------------
>  3 files changed, 66 insertions(+), 66 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
