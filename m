Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD49661E85
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Jan 2023 06:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjAIFsF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Jan 2023 00:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjAIFsF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Jan 2023 00:48:05 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBECF101EB;
        Sun,  8 Jan 2023 21:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=mYy4QLa5Bc/4vg/+uZDurLgr/sWAqCZvoyOVtncnewE=;
        b=gjMEc90VfrsdwOt6ntWyj8qyW8nFQxRFCCQqmwO+CDx2nL1zyZChfzfY1zo2InC+h1W5X8sdpjKDq
         S05iOgIpqMFWKnRyUpzV1laqc3ac5pAkE+hW03lHGBW4toFHlBA9e/uCbGjAwjZsMmxOenm2nZTV7W
         oSK/FxcifzN523LSILaZcQUXFD/oqf0alW873cxvm2N2r67t5ogAR8sfRncCrxdzTnj9sEWCN0a4TI
         SIMZWR4NXot6xdPrvUz79Ybfj5G7QaZjIwyPqDelkKnrOPmScdTx1kRpz03nTUqcUGSwlytqeg8pag
         9wmYyvmQEBREUsfU1APJIeLa+qVRclQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000008,0.009015)], BW: [Enabled, t: (0.000022,0.000001)], RTDA: [Enabled, t: (0.083450), Hit: No, Details: v2.42.0; Id: 15.52k466.1gmah40lc.1qubb; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([78.37.166.219])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 9 Jan 2023 08:47:41 +0300
Date:   Mon, 9 Jan 2023 08:47:42 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-fpga@vger.kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v5 0/3] Reliability improvements for Microchip MPF FPGA
 manager
Message-ID: <20230109054742.ola6gafnn2ikyuqa@x260>
References: <20221230092922.18822-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230092922.18822-1-i.bornyakov@metrotek.ru>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Dec 30, 2022 at 12:29:19PM +0300, Ivan Bornyakov wrote:
> A couple of reliability improvements for Microchip Polarfire FPGA
> manager:
>  * move SPI I/O buffers out of stack
>  * rewrite status polling routine in a time measurable way
> 
> Also improve mpf_ops_write() code readability by separating single data
> frame writing routine.
> 
> ChangeLog:
>   v1:
> [https://lore.kernel.org/linux-fpga/20221223123854.8023-1-i.bornyakov@metrotek.ru/]
>   v2:
>     * split into 3 distinct patches
> [https://lore.kernel.org/linux-fpga/20221226142326.8111-1-i.bornyakov@metrotek.ru/]
>   v3:
>     * fix polling stop condition in mpf_poll_status() as Ilpo suggested.
> [https://lore.kernel.org/linux-fpga/20221227100450.2257-1-i.bornyakov@metrotek.ru/]
>   v4:
>     * more verbose comment for mpf_poll_status()
> [https://lore.kernel.org/linux-fpga/20221229104604.2496-1-i.bornyakov@metrotek.ru/]
>   v5:
>     * revord "fpga: microchip-spi: move SPI I/O buffers out of stack"
>       commit message "Use allocated buffers" -> "Use cacheline aligned
>       buffers"
>     * drop __aligned(ARCH_KMALLOC_MINALIGN) attribute of struct mpf_priv
>       member "rx". tx and rx are used synchronously by dma, they could
>       share a cacheline.
> 
> Ivan Bornyakov (3):
>   fpga: microchip-spi: move SPI I/O buffers out of stack
>   fpga: microchip-spi: rewrite status polling in a time measurable way
>   fpga: microchip-spi: separate data frame write routine
> 
>  drivers/fpga/microchip-spi.c | 145 +++++++++++++++++++----------------
>  1 file changed, 79 insertions(+), 66 deletions(-)
> 
> -- 
> 2.38.2
> 

Friendly ping.

