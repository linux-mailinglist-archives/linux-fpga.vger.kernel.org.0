Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFEF6F1D4C
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Apr 2023 19:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346080AbjD1RTn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Apr 2023 13:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjD1RTm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 28 Apr 2023 13:19:42 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEF22720;
        Fri, 28 Apr 2023 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=nObl18fJ9OlLxUMBboQjJbVHX9jb/qswhdthtRflySw=;
        b=Ug5ycDX4WCSeEugTjpZ0ORd71VZpPbDrR3639bcmnOQz3ubsHGwZt9qi2B56f7YvAhnwdz9d8JPXk
         y2PkbQvWvXICuH2mJqynM3z+OzBMIgzRgG28dBEZz6JNiSw0dkek4TrK7UQm0QcB8Wl/xjjBKwvaIq
         3XKpW/O/ppVKJmZpuzhkyGlYtDVfjBqPUju4bpW1q1BfQHrPY+Lg2eYidnxsm3U5KQ1HIkska2nv+9
         T8u+8Qk1Lq/GhaAfw1HTNY3pOowqjjpgZeir+s7SB1Iyo+6i3ou/szqbXVsjY3eSxpMKz/75Kg3WTJ
         354mV9p9JNql+JFpK8o/q65ID+K5g6A==
X-Kerio-Anti-Spam:  Build: [Engines: 2.17.2.1477, Stamp: 3], Multi: [Enabled, t: (0.000009,0.005251)], BW: [Enabled, t: (0.000015,0.000001)], RTDA: [Enabled, t: (0.085530), Hit: No, Details: v2.49.0; Id: 15.wqtlv.1gv4e0pno.smbv; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([78.37.166.219])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 28 Apr 2023 20:19:19 +0300
Date:   Fri, 28 Apr 2023 20:19:17 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Vladimir Georgiev <v.georgiev@metrotek.ru>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] replace Ivan Bornyakov maintainership
Message-ID: <20230428171917.k5cdt7wb5pjof6di@x260>
References: <20230428140150.2592-1-i.bornyakov@metrotek.ru>
 <20230428-marine-halogen-57d4b3c2ca0f@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428-marine-halogen-57d4b3c2ca0f@spud>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Apr 28, 2023 at 05:55:52PM +0100, Conor Dooley wrote:
> On Fri, Apr 28, 2023 at 05:01:48PM +0300, Ivan Bornyakov wrote:
> > As I'm leaving Metrotek, hand over my maintainership duties to Vladimir.
> 
> As I said yesterday, good luck!
> 

Thank you!

> > ChangeLog:
> > v1:
> > https://lore.kernel.org/lkml/20230426073519.9167-1-i.bornyakov@metrotek.ru/
> > v2:
> >   * instead of replacing my Metrotek email to a shared Metrotek System
> >     Team mailbox, assign Vladimir to my former maintainership.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.



