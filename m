Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7A752A32D
	for <lists+linux-fpga@lfdr.de>; Tue, 17 May 2022 15:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347451AbiEQNUG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 May 2022 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbiEQNUE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 May 2022 09:20:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910AA41F94;
        Tue, 17 May 2022 06:20:02 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AF4512ED;
        Tue, 17 May 2022 13:20:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AF4512ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652793601; bh=DJOZJLYA1yyhX9firYLLzDoQKmaoGsbueo8T2NVcZA0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eT+aTSeeUcGfy69B3SJ3LA7+bRXcSQhUi4gE9PaLZ//fNCSAEzr4PLMbOv/TpRnZr
         JWkgsVGG6WPjbm1OZG1p7Ui9FUUILCOJurFcIXJYlVWIEtC4L4nlSAC+4sRon5eQNW
         bMMQH+spSOQU35hHAuUKjVy0AV+ZCxYnPVjxyijdMY5XLUdCofDr06X47msFXjBuNn
         bHRpP+xY89PTEJvEYl9D1Aaieqcq8BaFZHLD7Td8B5iZh4oSfHDdyjgkNGgrqAqlDB
         RQ5C2NYwczyp9IOQVGH2bSTKZRGgQdp7RpIepWVH/fV42VXj34KIPCSlgK+41owxuq
         x57LMNoeJ4t1g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     adrian.ho.yin.ng@intel.com, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Tull <atull@opensource.altera.com>
Subject: Re: [PATCH 2/3] fpga: doc: documentation for FPGA debugfs
In-Reply-To: <20220517084136.3529-1-adrian.ho.yin.ng@intel.com>
References: <20220517084136.3529-1-adrian.ho.yin.ng@intel.com>
Date:   Tue, 17 May 2022 07:20:00 -0600
Message-ID: <874k1oz473.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

adrian.ho.yin.ng@intel.com writes:

> From: Alan Tull <atull@opensource.altera.com>
>
> Document the DebugFS interface for the core FPGA Manager
> framework.
>
> Signed-off-by: Alan Tull <atull@opensource.altera.com>
> ---
>  Documentation/fpga/debugfs.txt | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/fpga/debugfs.txt

If you add a new documentation file, you need to add it to index.rst as
well so that it is part of the kernel docs build.

Honestly, though, this looks like it might be better placed in the
user-space API manual...?

Thanks,

jon
