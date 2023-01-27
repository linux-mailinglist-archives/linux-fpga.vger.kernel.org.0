Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5674067E240
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 11:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjA0KuY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 05:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjA0KuV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 05:50:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9DB77515;
        Fri, 27 Jan 2023 02:50:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA95DB82020;
        Fri, 27 Jan 2023 10:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9BAC433D2;
        Fri, 27 Jan 2023 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674816613;
        bh=Ndb0nS2N0G7+DIf7lAYIYXjsGEhWmju0do+/+japCyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKmXN8JX3L1PzdRd6a7Zj9oY04HbdGEeGJ1BZkmiGj2yiWvLp9h7joroBL7WNLmY9
         wc/yOWYu6a4YJMI/dcFDYFjCBv+rvjprohDW+dg6A1FmW+Shy0fD/7GlQJa5z70zxU
         Hdzvvbg1p1A8otBOthG6LefQ0HPsANJ6MEEJsWa9VUcOedIVWWlfRGr0HoasbxMY0Z
         Q1icVV8KnFSjIcf1NGODXOfoZugVZLj3DBC3wpiMezqjbiUUgLM7y6W/1F3X+tbMhk
         KZlCKq9VFrpT3Jcuvdq+plRqZdnpwTe4sVn7kGQPKH0rcJ7R6dQ+jkJM9RLbolRPFr
         giuCfsBGRXPsA==
Date:   Fri, 27 Jan 2023 10:50:07 +0000
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
Subject: Re: [PATCH v6 10/11] mfd: intel-m10-bmc: Add PMCI driver
Message-ID: <Y9OsX5d222fp47BF@google.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <20230116100845.6153-11-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116100845.6153-11-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 16 Jan 2023, Ilpo Järvinen wrote:

> Add the mfd driver for the Platform Management Component Interface
> (PMCI) based interface of Intel MAX10 BMC controller.
> 
> PMCI is a software-visible interface, connected to card BMC which
> provided the basic functionality of read/write BMC register. The access
> to the register is done indirectly via a hardware controller/bridge
> that handles read/write/clear commands and acknowledgments for the
> commands.
> 
> Previously, intel-m10-bmc provided sysfs under
> /sys/bus/spi/devices/... which is generalized in this change because
> not all MAX10 BMC appear under SPI anymore.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
>  drivers/mfd/Kconfig                           |  12 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/intel-m10-bmc-pmci.c              | 219 ++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h             |  28 +++
>  5 files changed, 264 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c

Applied, thanks

-- 
Lee Jones [李琼斯]
