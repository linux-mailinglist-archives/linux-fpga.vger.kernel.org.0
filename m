Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AE867E1D8
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 11:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjA0Khl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 05:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjA0Khk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 05:37:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB47984B65;
        Fri, 27 Jan 2023 02:37:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AFC961AC8;
        Fri, 27 Jan 2023 10:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F364FC433D2;
        Fri, 27 Jan 2023 10:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674815856;
        bh=pCrqKbNu6hlxmQ1HVuabbKLuxn3WATXpfYLfUrmMBSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqHAC/aPfKIS1iDdJ8euU5kEPYkAQnojw0f7fuWzupygQed9o7DH48eTo7mVDsulY
         eE5+7iRTI/pyX1txoD2kbkgbrDjTmJ0OotR6+gqoFB/DtzFIzM+337FdUC96dcenVg
         aSBs/S8EKVU4wsMrJ1wb0L6JRR8NsDMTfRRniZSiByJZJaR7yLa4bYgsXjeOj/xul1
         YtWL8zaxyum8koF3iXEtEne1zpWkC4iV5s3XzVnYCINQ9zPH/Qd+kKaoHGPII/8hNT
         ZjsSHvvFopdzMyU4AHIeMB/bCA/pjMQGwL421aNhV6kT6MkJoB6mehGZTpiJGWaWV2
         t+kAVGpqvbXkw==
Date:   Fri, 27 Jan 2023 10:37:30 +0000
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
Subject: Re: [PATCH v6 06/11] fpga: intel-m10-bmc: Rework flash read/write
Message-ID: <Y9Opau9cyEmP7zlN@google.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <20230116100845.6153-7-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116100845.6153-7-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 16 Jan 2023, Ilpo Järvinen wrote:

> Access to flash staging area is different for N6000 from that of the
> SPI interfaced counterparts. To make it easier to differentiate flash
> access path, move read/write into new functions where the new access
> path can be easily placed into. Rework the unaligned access such the
> behavior it matches for both read and write.
> 
> This change also renames m10bmc_sec_write() to m10bmc_sec_fw_write() as
> it would have a name conflict otherwise.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 143 +++++++++++++-----------
>  1 file changed, 79 insertions(+), 64 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
