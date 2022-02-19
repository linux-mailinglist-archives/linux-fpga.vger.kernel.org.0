Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980314BC7CC
	for <lists+linux-fpga@lfdr.de>; Sat, 19 Feb 2022 12:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbiBSLEL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 19 Feb 2022 06:04:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240384AbiBSLEF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 19 Feb 2022 06:04:05 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3867A6A075;
        Sat, 19 Feb 2022 03:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=iYUDiAjoLie13BkDtYO7gp/SKHNnEFJhm4CtBUuVL2E=;
        b=dNY7HR+O49q7ko5z+fV9Du3c5CZrY2LVT8eNks5f1MuYipM9O0SozDdBy85ZStEcLcyvmhWJf2msA
         nPKcfhNYKRUnSAzdMEVDdD2rDlntg98TlEvei775JvBv8zKJuYr5OF0SSiZ77zR87FEYE6jmacRx05
         hW4gJCz/hf1GAyLNlIXYj8HnxObygmi3n0mHM2VpyG9uob57R8Qo1UhvFzCtmxSO1oB8SkkO4Pcu3n
         QgnbKnR4GijBtYFQmqrv4izsePd3Gb56UdzwvvPZkEJ74ztR7jpBZ0Skgu6NfdKDfQayxJvrLrz78r
         lqP2tW6pVPPafnlmcjc9v8jmywdpAQg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1403, Stamp: 3], Multi: [Enabled, t: (0.000009,0.005103)], BW: [Enabled, t: (0.000029,0.000001)], RTDA: [Enabled, t: (0.066537), Hit: No, Details: v2.25.0; Id: 15.52k1vm.1fs8q8lsh.r23u; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.66.234])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Sat, 19 Feb 2022 14:00:54 +0300
Date:   Sat, 19 Feb 2022 13:42:55 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v4] fpga: microchip-spi: add Microchip FPGA manager
Message-ID: <20220219104255.smgqcqlez6sdo4hk@x260>
References: <20220214133835.25097-1-i.bornyakov@metrotek.ru>
 <20220217191851.11730-1-i.bornyakov@metrotek.ru>
 <20220218160555.GA1333893@yilunxu-OptiPlex-7050>
 <20220219061627.3oanqx5glsyq47xk@x260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219061627.3oanqx5glsyq47xk@x260>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Feb 19, 2022 at 09:16:27AM +0300, Ivan Bornyakov wrote:
> On Sat, Feb 19, 2022 at 12:05:55AM +0800, Xu Yilun wrote:
> >
> > Maybe the bitstream info at the head of the image could be parsed in
> > write_init(), and this requires the driver fill the
> > fpga_manager_ops.initial_header_size
> >
> 
> Header size is not known beforehand and is stored in 25th byte of the
> image.
> 

Actually I was not quite accurate here. The header itself seems to be of
constant size according to
https://coredocs.s3.amazonaws.com/DirectC/2021_2/spi_directc.pdf
(4. Data File Format)

But the lookup table is definitely of a variable size. Moreover
bitstream start and size both are somewhere in the image and needed
to be located through lookup table.

