Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26A967E221
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 11:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjA0Koj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 05:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjA0Kob (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 05:44:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6502134C1D;
        Fri, 27 Jan 2023 02:44:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00F9C61AD5;
        Fri, 27 Jan 2023 10:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8FDC433A0;
        Fri, 27 Jan 2023 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674816252;
        bh=ynTmj3b4CBObQ1WhT58swNRUJrBAzRCbyyjV8tvQOeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nIq3g8Iyvv7jAql5cP8aaXB44NLxyFsez6brpzTyYorxVdi7gxQPlKVLbv0z69xVG
         Uny8JS4MO2Nwldfx9ViaHF8paXDefC4sTmEdygYdoazDdrdkNsuM9M71fDVYkoO6g8
         uMydwXAbVqCrg/JCH0L1dq6fR4y0bnnkywagSC/05lHz662Rno4j54NNrMmuusVxbW
         UP62Lka3R3+jyrCj+XT1+a7PjlDhE2DPl7KT0zhINQwnKioxhq4eMA8khAr7tGTFZu
         bmsrwA/JeS4iYRIhCQYeF20UIGAlLvYz7ceMz5m2wIeEEz8q3M8OcaMAQ0xZVhcoRM
         uBX2lj/cecGuw==
Date:   Fri, 27 Jan 2023 10:44:06 +0000
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
Subject: Re: [PATCH v6 09/11] fpga: m10bmc-sec: Make rsu status type specific
Message-ID: <Y9Oq9hlhoTlzndNZ@google.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <20230116100845.6153-10-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116100845.6153-10-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Mon, 16 Jan 2023, Ilpo Järvinen wrote:

> The rsu status field moves from the doorbell register to the auth
> result register in the PMCI implementation of the MAX10 BMC. In order
> to prepare for that, refactor the sec update driver code to have a type
> specific ops that provides ->rsu_status().
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 109 +++++++++++++++++-------
>  include/linux/mfd/intel-m10-bmc.h       |   1 -
>  2 files changed, 78 insertions(+), 32 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
