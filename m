Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A812E669B17
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jan 2023 15:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjAMO4f (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 13 Jan 2023 09:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjAMO4E (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 13 Jan 2023 09:56:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C068D5FD;
        Fri, 13 Jan 2023 06:42:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A890B82171;
        Fri, 13 Jan 2023 14:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CBFC433EF;
        Fri, 13 Jan 2023 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673620934;
        bh=f9xYLBEdIZS6xHzO4ogzkto2j4CKNmGShIFM0BXcVss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QEmS8yn2txSOdlKbJJdbxLku7cU0PZmRStyAP87J55DPSpT5bLoSZTJ4RS4RtLR4W
         t6kYnPrwqhKS80huFweNl+qeVEpgtzWn61YFL8E2uPhU76pZ0kVmJrZI+Giq56HLrA
         81VthUgoJyRkVfmJ4dw/I62vcnxstsrqEoSSufm+5sr4bw5BUBdKdWKiHhlK3bxauQ
         iNePD7wwrxuQBpHNAeiQsQzgnDNFOuDpwt0ZaLczp2/8pL+SUYOBmYMKjdO/AZxbnb
         5gl8FZqxDz2OJpkzPoqKJXwDsGE0ofX4EOjGE1Sse5iy68PhS/yQOYIbV7YT1w9yUd
         wMM6SZITU3CGw==
Date:   Fri, 13 Jan 2023 14:42:07 +0000
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
Subject: Re: [PATCH v5 03/10] mfd: intel-m10-bmc: Split into core and spi
 specific parts
Message-ID: <Y8Ftv3/SwNI403I3@google.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
 <20221226175849.13056-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221226175849.13056-4-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 26 Dec 2022, Ilpo Järvinen wrote:

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

Looks okay:

For my own reference (apply this as-is to your sign-off block):

Acked-for-MFD-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
