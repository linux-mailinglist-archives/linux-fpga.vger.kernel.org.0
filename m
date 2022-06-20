Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC9E5523D4
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Jun 2022 20:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245283AbiFTSYl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jun 2022 14:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243531AbiFTSYj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Jun 2022 14:24:39 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAAF13FB1;
        Mon, 20 Jun 2022 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=QGRD7oCFnD0lIO8/JoEbhbSbKlBmQoT6/CM5t/z0lq0=;
        b=Rs0lnhxnt3PHGmfTFT8RdCyWPbeC/GTAAC+g29x5fJw/dxVOCPw266tV9uvNUPHix4i4btMiu88C4
         A5OQYk0qlWdBU1Szg1ykmtSXYPZEsQYNagcXSyWf6iZx8owf2JriIBi9g0zi6NhSkJ01N9RqE0hCcS
         r6tokCRsaijAGiC5WAgwfvHHv9lpuYq3VtWlrMV1yHLdidEw0UmHKSnNyKWS0ewe5NzlvvjTzDm+8J
         +EvGfTqVGII//YbHHQUq8/0G/OCzeT4l1tZaJMNH/JE+CA0FtMyRKxdJZW9wZ2ZKr6h+wtip80FByO
         imu4dfAEm1FifFLE3i9m/SI2nFD0tFg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000008,0.008251)], BW: [Enabled, t: (0.000015,0.000001)], RTDA: [Enabled, t: (0.076561), Hit: No, Details: v2.40.0; Id: 15.52k3tn.1g615nd38.16l4n; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 20 Jun 2022 21:24:15 +0300
Date:   Mon, 20 Jun 2022 21:01:06 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     corbet@lwn.net, devicetree@vger.kernel.org, hao.wu@intel.com,
        krzysztof.kozlowski+dt@linaro.org, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, robh+dt@kernel.org, system@metrotek.ru,
        trix@redhat.com, yilun.xu@intel.com
Subject: Re: [PATCH v20 0/4] Microchip Polarfire FPGA manager
Message-ID: <20220620180106.a5o53zr2waxkoay6@x260>
References: <20220620100745.yxjmq2qtsicxlrgn@h-e2.ddg>
 <20220620105747.2145347-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620105747.2145347-1-conor.dooley@microchip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 20, 2022 at 11:57:48AM +0100, Conor Dooley wrote:
> I had a quick check in -next and there's an entry for the BMC
> driver there.
> How about the following? I put you as R, but clearly if you want to be
> maintainer then you are *more than* qualified.
> Feel free to edit the patch if so, either is fine by me.
> You can tack this onto a v21 if you have more changes or I can resend
> standalone once the driver is merged.
> 
> Thanks,
> Conor.
> 
> From: Conor Dooley <conor.dooley@microchip.com>
> Date: Mon, 20 Jun 2022 11:46:19 +0100
> Subject: [PATCH] MAINTAINERS: add polarfire fpga programmer drivers
> Add a MAINTAINERS entry for the newly added PolarFire (MPF) SPI slave
> programming driver.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 168e0af869a7..60ab3c4bf65d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7869,6 +7869,14 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>  F:	drivers/fpga/intel-m10-bmc-sec-update.c
>  
> +FPGA PolarFire Drivers
> +M:	Conor Dooley <conor.dooley@microchip.com>
> +R:	Ivan Bornyakov <i.bornyakov@metrotek.ru>
> +L:	linux-fpga@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> +F:	drivers/fpga/microchip-spi.c
> +
>  FPU EMULATOR
>  M:	Bill Metzenthen <billm@melbpc.org.au>
>  S:	Maintained
> 
> base-commit: 07dc787be2316e243a16a33d0a9b734cd9365bd3
> -- 
> 2.36.1
> 

Ok, I'll add this to v21, but I'll wait for a review on fpga-mgr changes
first.

