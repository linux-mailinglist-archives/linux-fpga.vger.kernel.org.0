Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9131E6F07E6
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Apr 2023 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbjD0PFR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Apr 2023 11:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243891AbjD0PFQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 27 Apr 2023 11:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80032421B;
        Thu, 27 Apr 2023 08:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B12463922;
        Thu, 27 Apr 2023 15:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A53C433EF;
        Thu, 27 Apr 2023 15:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682607913;
        bh=USGb2Wg8GY6At3rpNMi26N87jmtxoV6TgO3XNM1TOw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/LTf1vjRX5yTQe3qUtzCButBcyBN52xGlEeWMG0DRnCzSJGGcFKz+3uQiySk7GHz
         Eh2EoZp5rAsYZhdB7JxeUqyJx4EnSMwh/lRxC14InO0m9kBvafGXY/FKiFL8c5Kue0
         P2ZvUcOcYPln79uqDLv0dlIGRE6DfQ3fVneKslJe7e6TSJoFCOc1uEoY5Btu+QguU4
         Hj+9ennU+gyievYFDxwWAQ4MmIEAlJ1SjeAnW0DM4TZkAV3yRbdNz50DdEcLucD4CX
         7EepUCEXj6RFucL9s3J3dr+otq0zreGR0vekO9w0TFMxhHFunfoJG9/3bQzkWKKNcC
         m3z4WDWeV1MIw==
Date:   Thu, 27 Apr 2023 16:05:08 +0100
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mfd: intel-m10-bmc: Move core symbols to own
 namespace
Message-ID: <20230427150508.GS50521@google.com>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
 <20230417092653.16487-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417092653.16487-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 17 Apr 2023, Ilpo Järvinen wrote:

> Create INTEL_M10_BMC_CORE namespace for symbols exported by
> intel-m10-bmc-core.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/mfd/intel-m10-bmc-core.c | 4 ++--
>  drivers/mfd/intel-m10-bmc-pmci.c | 1 +
>  drivers/mfd/intel-m10-bmc-spi.c  | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
