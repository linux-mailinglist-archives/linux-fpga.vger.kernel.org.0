Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665C867E1A9
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 11:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjA0K3W (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 05:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjA0K3V (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 05:29:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD24383F7;
        Fri, 27 Jan 2023 02:29:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65157B81F96;
        Fri, 27 Jan 2023 10:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A565CC433EF;
        Fri, 27 Jan 2023 10:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674815358;
        bh=9Wg11kzEaN+HhlY3OKtXJh9GogO1zPDrG6yCaMO4HdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mz1gqUWxi96H9idFqCXLZ42GwrWyNcwMFSl2sn4Rr2ZyOfHZabxg/QrN9m/hyj/N5
         ajanWgGXgxKGInc8Q/H045hOEeOfB6iAoe1tqwueJPF6FtUmqmgqXCy+jyraDmFcbh
         2RdG3EcuXW9AAP1QsqV87rkpTyj7Dis0II42ngIIVJFqB2ckgcFzFmchrO9QQDOqIX
         TBCDoVfn3NPGD67mMD5LBojBLMWrhnNzjsw2eJfa942JKtBalECyuML/ksZZlVl0J/
         ERWLf6HgKT0MnU1XI69OQENbito6fl359MQkm9Vq31cuyKv3bXYTj3hrdmdmuUxUtN
         +Kc9xIxcMGNUw==
Date:   Fri, 27 Jan 2023 10:29:11 +0000
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
Subject: Re: [PATCH v6 03/11] mfd: intel-m10-bmc: Rename the local variables
Message-ID: <Y9Ond5ejfxd+BaYx@google.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <20230116100845.6153-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116100845.6153-4-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 16 Jan 2023, Ilpo Järvinen wrote:

> Local variables directly interact with dev_get_drvdata/dev_set_drvdata
> should be named ddata.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/mfd/intel-m10-bmc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
