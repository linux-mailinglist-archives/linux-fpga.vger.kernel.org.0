Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C905682874
	for <lists+linux-fpga@lfdr.de>; Tue, 31 Jan 2023 10:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjAaJMm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 31 Jan 2023 04:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjAaJMY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 31 Jan 2023 04:12:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8554DCF5
        for <linux-fpga@vger.kernel.org>; Tue, 31 Jan 2023 01:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C073FB81A16
        for <linux-fpga@vger.kernel.org>; Tue, 31 Jan 2023 09:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361B3C433D2;
        Tue, 31 Jan 2023 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675156120;
        bh=5UkNgNNFkBIHn9mGTardJyppXjyoAkY6aMjwJDqBmsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gxq5axj//tCD5Orwr1xwB66RJS6ZlkHX6v/YCwprPix315n9CVxSIeNdX5tQv0Yaz
         uC1iI8kGYRu3faHils8HWgcCfOPQjn0WcPZs5My948nvwgEI2fWvKCjl6QAJQ13ujY
         23A0/bSqYLTp4aOPcbhXm7BsWfu+ijVkSnOuEb0dDHASfRkohNg5/5/lEjm1+MjpmY
         H5zzT9KbHDoXMqNf7GooIVRo3phCJIifh1JGtT6CTMmNoxBVvC92dvjx/PUpQYWZnf
         49xxb7moKNm9HEFGiI92S2Kn9otTMJVrJGEdviGrFDsa+jNWf3zXvaB/cVwFXGNpT9
         1lqAVf4CwEtLQ==
Date:   Tue, 31 Jan 2023 09:08:35 +0000
From:   Lee Jones <lee@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        hao.wu@intel.com, mdf@kernel.org
Subject: Re: [PATCH 1/1] fpga: m10bmc-sec: Add support for N6000
Message-ID: <Y9jak/PLJLfDY1Pl@google.com>
References: <20230131024121.940195-1-yilun.xu@intel.com>
 <20230131024121.940195-2-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131024121.940195-2-yilun.xu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, 31 Jan 2023, Xu Yilun wrote:

> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Add support for PMCI-based flash access path and N6000 sec update
> support. Access to flash staging area is different for N6000 from that
> of the SPI interfaced counterparts.
> 
> Introduce intel_m10bmc_flash_bulk_ops to allow interface specific
> differentiations for the flash access path for sec update and make
> m10bmc_sec_read/write() in sec update driver to use the new operations.
> The .flash_mutex serializes read/read. Flash update (erase+write) must
> use ->lock/unlock_write() to prevent reads during update (reads would
> timeout on setting flash MUX as BMC will prevent it).
> 
> Create a type specific RSU status reg handler for N6000 because the
> field has moved from doorbell to auth result register.
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
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Link: https://lore.kernel.org/r/20230116100845.6153-12-ilpo.jarvinen@linux.intel.com
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c |  51 ++++-
>  drivers/mfd/intel-m10-bmc-pmci.c        | 242 +++++++++++++++++++++++-
>  include/linux/mfd/intel-m10-bmc.h       |  51 +++++
>  3 files changed, 336 insertions(+), 8 deletions(-)

I'm confused, what are you trying to achieve?

Who are you sending this to?

-- 
Lee Jones [李琼斯]
