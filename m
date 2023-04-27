Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26C66F07EA
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Apr 2023 17:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbjD0PF4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Apr 2023 11:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243444AbjD0PF4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 27 Apr 2023 11:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF131992;
        Thu, 27 Apr 2023 08:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E047661828;
        Thu, 27 Apr 2023 15:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59025C433EF;
        Thu, 27 Apr 2023 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682607954;
        bh=hqsAt21ys4sFAbKQce2SZIGXxdHnYKWpl3zHqzIPiwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fK3Tsgo9SZgaIUAho2tDahO0cZuMHWDOi5REBWbmA0tqWEa3b/7PT+2J1EP6sas4F
         YotGtefjiNQzODDLo42niIYHT9QDWoBpFTduWtOJwbCbfjIIWdTEGIEM3UXjsaF9ew
         7uogcfd3UXUtsyXuqv2p6oZkKCW1xNFc5yXLCVTloyXkQ81t0trm6ARKaFIRGYsPoL
         v+zJ8Y7pv6unfJxFT+EhSRqcfPNi2Lxo/gOiiUGKe2tjTJ4HRIkdNaqJ1l4BT4S2H5
         G5+aWsASrG1Va+EMLMSwFokCjLRCDlvHEh4sMJpnCamKGcrgVuicXKWkgnsLfXokuZ
         4cyq14DdfRtjw==
Date:   Thu, 27 Apr 2023 16:05:49 +0100
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mfd: intel-m10-bmc: Create
 m10bmc_sys_update_bits()
Message-ID: <20230427150549.GT50521@google.com>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
 <20230417092653.16487-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417092653.16487-3-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 17 Apr 2023, Ilpo Järvinen wrote:

> Wrap regmap_update_bits() with m10bmc_sys_update_bits() in order to be
> able to add additional checks into it.
> 
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 30 ++++++++++++-------------
>  drivers/mfd/intel-m10-bmc-core.c        |  9 ++++++++
>  include/linux/mfd/intel-m10-bmc.h       |  4 ++++
>  3 files changed, 27 insertions(+), 16 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
