Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1467E4BC5FB
	for <lists+linux-fpga@lfdr.de>; Sat, 19 Feb 2022 07:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240967AbiBSGEa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 19 Feb 2022 01:04:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiBSGE2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 19 Feb 2022 01:04:28 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB51A50B22;
        Fri, 18 Feb 2022 22:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=D1jy9GhEsVubcUXI+Jry21k0Psv3ZkSi5Qf5DSDs7NY=;
        b=OPBXyFknn0qq0XBgeJK8aPJoUA0HGQV1Egpv90CA7UQDlAS47x2FP6BwzRRp5SQPhLDyMt3XVTd6I
         qgTMTq4xKS8B+xgP+wJkJXHi9cT+ZmFwLgiSz5TPKB9xCLThdgapnc/W7uK0gsKqoL3r67/0Klz/wM
         hSOcweIr7wofGNwHZ4k9aHArH4yy0LzvXWBJsXBFkz2+Ww5X+GZa8LnTShKOZ1AbFr0wAEJSp4i16u
         ca9XaQmSVrm90C+9H8O9+y05uVyyN94q3A7xluxwNz1INrRHj210Bgd5gnuMxy5/eA/AVNUg029zjQ
         SVNNLB04q8D5cfVm5ROC04j2VVHo7CQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1403, Stamp: 3], Multi: [Enabled, t: (0.000016,0.006062)], BW: [Enabled, t: (0.000028,0.000002)], RTDA: [Enabled, t: (0.097144), Hit: No, Details: v2.25.0; Id: 15.52k2f3.1fs898kro.vphl; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.66.234])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Sat, 19 Feb 2022 09:03:48 +0300
Date:   Sat, 19 Feb 2022 08:45:57 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor.Dooley@microchip.com
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v4] fpga: microchip-spi: add Microchip FPGA manager
Message-ID: <20220219054557.5jb2om2ydy4ivhd5@x260>
References: <20220214133835.25097-1-i.bornyakov@metrotek.ru>
 <20220217191851.11730-1-i.bornyakov@metrotek.ru>
 <e86d4a9e-79d8-706b-aea5-153e2efcdfc3@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e86d4a9e-79d8-706b-aea5-153e2efcdfc3@microchip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi, Conor

On Fri, Feb 18, 2022 at 03:22:57PM +0000, Conor.Dooley@microchip.com wrote:
> Hey Ivan,
> Finally got my hands on a board with a non SoC PolarFire today & started
> trying to test. Ran into problems with my SPI setup - would be nice to
> know if youre currently doing the reprogramming on one of our devkits
> etc or on a custom board of your own?
> Will be Monday before I can have look at it again, will have another
> board I can try then in the odd chance this one isnt actually capable of
> reprogramming.
> Thanks,
> Conor.
> 

I'm working with a custom board.

