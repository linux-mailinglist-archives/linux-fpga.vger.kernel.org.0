Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C7867E1C6
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 11:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjA0Kfh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 05:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjA0Kfg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 05:35:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392692BF2E;
        Fri, 27 Jan 2023 02:35:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D48FB61ABA;
        Fri, 27 Jan 2023 10:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F79C433D2;
        Fri, 27 Jan 2023 10:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674815734;
        bh=HfboOUqkDcJtk7EdCMJ836mjQ3bu7QFH2c7xi9xlIoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYqbNl1NRR8pe5dhUiIsNZR35SUvwS1d74Br3jOZ+pP2DWth2Ai04iXzifIVqDo//
         nJlc2n/VHu5s3aTEJiWoT0mxBMllxS0iQk1DJ4NqGsf9znFVwgIMy6Jcws17xT1OJM
         Q3bDq62TJFuoCYDB301hvpp6aaMuGXWymvzF0Fh6ZsJbDb2JjqZjOGFYuAaDhgya/g
         DpEkpSPM1bl1zD/Jp2SBt1X2ChONZf7AvllBY8hKFj7WPvn5U2QVC5HPumWDYMU3tF
         jsdAwnoNDgyMyhXqOK1hcuPilmxdnK5y2mKOCy/bM2Yt5QQJX4HtErdO4932K6fbIP
         TQGrXqggsw4jw==
Date:   Fri, 27 Jan 2023 10:35:27 +0000
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
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v6 04/11] mfd: intel-m10-bmc: Split into core and spi
 specific parts
Message-ID: <Y9Oo74EmSiA9Kngb@google.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <20230116100845.6153-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116100845.6153-5-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 16 Jan 2023, Ilpo Järvinen wrote:

> Split the common code from intel-m10-bmc driver into intel-m10-bmc-core
> and move the SPI bus parts into an interface specific file.
> 
> intel-m10-bmc-core becomes the core MFD functions which can support
> multiple bus interface like SPI bus.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net> # hwmon
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  MAINTAINERS                                   |   2 +-
>  drivers/fpga/Kconfig                          |   2 +-
>  drivers/hwmon/Kconfig                         |   2 +-
>  drivers/mfd/Kconfig                           |  30 ++--
>  drivers/mfd/Makefile                          |   4 +-
>  drivers/mfd/intel-m10-bmc-core.c              | 122 +++++++++++++++++
>  .../{intel-m10-bmc.c => intel-m10-bmc-spi.c}  | 128 +++---------------
>  include/linux/mfd/intel-m10-bmc.h             |   6 +
>  8 files changed, 172 insertions(+), 124 deletions(-)
>  create mode 100644 drivers/mfd/intel-m10-bmc-core.c
>  rename drivers/mfd/{intel-m10-bmc.c => intel-m10-bmc-spi.c} (59%)

Applied, thanks

-- 
Lee Jones [李琼斯]
