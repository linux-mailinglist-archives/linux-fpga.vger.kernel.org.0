Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2DB661EAD
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Jan 2023 07:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjAIGXh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Jan 2023 01:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjAIGXg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Jan 2023 01:23:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F366ABE13;
        Sun,  8 Jan 2023 22:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673245415; x=1704781415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=99wwgki3vDnEuMvkqt8gVpIBfAzSTXbaAFnjD0Am8uM=;
  b=TXG/k2G1zpRCIiXnwkuyIceCGcUQ+ZtORd2/8z91bG5M28QxdhUgtPrO
   NYKDCfzdU7GegSGOte3dKTFspB5MJr9Qod/VFMwb0SYfm8M/GGTOOwa42
   6gtACUS52Wz0Dk23hsfZKU99uocLhQUeEBqw6xshDPdf/X+aJbAh4IiDI
   YpUvvJbvM6A+mbXkrxwEBSwk5vSqB7nBhdS818P5Jn1LFmCkYr8HTD2Ux
   qUQFSgH0cqSBzHRo2RPnTWQQlrsZfih9DGja8VYlDGa9A7EpLESxWK4XV
   H2UgTouRSXpTdmSp3VhSES2qP2PVr82xS2+uq/w6lekm6FmKGGCMx708Z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="302501575"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="302501575"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 22:23:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649919372"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649919372"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 22:23:32 -0800
Date:   Mon, 9 Jan 2023 14:13:16 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     linux-fpga@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v5 0/3] Reliability improvements for Microchip MPF FPGA
 manager
Message-ID: <Y7uwfCPAl15Db8G6@yilunxu-OptiPlex-7050>
References: <20221230092922.18822-1-i.bornyakov@metrotek.ru>
 <20230109054742.ola6gafnn2ikyuqa@x260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109054742.ola6gafnn2ikyuqa@x260>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-01-09 at 08:47:42 +0300, Ivan Bornyakov wrote:
> On Fri, Dec 30, 2022 at 12:29:19PM +0300, Ivan Bornyakov wrote:
> > A couple of reliability improvements for Microchip Polarfire FPGA
> > manager:
> >  * move SPI I/O buffers out of stack
> >  * rewrite status polling routine in a time measurable way
> > 
> > Also improve mpf_ops_write() code readability by separating single data
> > frame writing routine.
> > 
> > ChangeLog:
> >   v1:
> > [https://lore.kernel.org/linux-fpga/20221223123854.8023-1-i.bornyakov@metrotek.ru/]
> >   v2:
> >     * split into 3 distinct patches
> > [https://lore.kernel.org/linux-fpga/20221226142326.8111-1-i.bornyakov@metrotek.ru/]
> >   v3:
> >     * fix polling stop condition in mpf_poll_status() as Ilpo suggested.
> > [https://lore.kernel.org/linux-fpga/20221227100450.2257-1-i.bornyakov@metrotek.ru/]
> >   v4:
> >     * more verbose comment for mpf_poll_status()
> > [https://lore.kernel.org/linux-fpga/20221229104604.2496-1-i.bornyakov@metrotek.ru/]
> >   v5:
> >     * revord "fpga: microchip-spi: move SPI I/O buffers out of stack"
> >       commit message "Use allocated buffers" -> "Use cacheline aligned
> >       buffers"
> >     * drop __aligned(ARCH_KMALLOC_MINALIGN) attribute of struct mpf_priv
> >       member "rx". tx and rx are used synchronously by dma, they could
> >       share a cacheline.
> > 
> > Ivan Bornyakov (3):
> >   fpga: microchip-spi: move SPI I/O buffers out of stack
> >   fpga: microchip-spi: rewrite status polling in a time measurable way
> >   fpga: microchip-spi: separate data frame write routine
> > 
> >  drivers/fpga/microchip-spi.c | 145 +++++++++++++++++++----------------
> >  1 file changed, 79 insertions(+), 66 deletions(-)
> > 
> > -- 
> > 2.38.2
> > 
> 
> Friendly ping.
> 

Patch #1 is good to me now. And applied this series to for-next

Thanks,
Yilun
