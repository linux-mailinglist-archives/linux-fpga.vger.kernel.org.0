Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E877767E1FB
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 11:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjA0Kj7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 05:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjA0Kj6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 05:39:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAA61E1E8;
        Fri, 27 Jan 2023 02:39:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9A0661AA9;
        Fri, 27 Jan 2023 10:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7185FC433EF;
        Fri, 27 Jan 2023 10:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674815990;
        bh=ALDAy1u9uqiOZ0CXMkXqHHSRRnaNCgcLwgBuqJuhpyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEyE+Hg6ZwVr4FFL3ZdKZB67SXIVQo3LQz5SypDXWOlzUXpZa4itb+2VEP2WV8qpq
         vGf/V0/NEmGkqWy2v525AUxEcqf7J6X3uvldq0sx6Eo+nVQjnIlER45zhci3yvOKWx
         mrOzN6Qm+0IiKssaWOVyC+0gug94wj0DErX18aeEKib6m9PbQdpeEmB/OBv7/jsAIP
         rwVkno2tLc2bcPfNSMQoPuoJyY2FyXwLmATVNlzJoWEfQ7SkqUyON64BV5YPMkd9pW
         XG2JDdHAeAeN6tm+q7sJRrtbbCA8llIMQnFJ7CNnfrH9ePGhGCFjU2l9cbSg2Bz0Y8
         F+03rMJdTr45Q==
Date:   Fri, 27 Jan 2023 10:39:44 +0000
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
Subject: Re: [PATCH v6 08/11] fpga: m10bmc-sec: Create helpers for rsu
 status/progress checks
Message-ID: <Y9Op8N4j+mQWrJlN@google.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <20230116100845.6153-9-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116100845.6153-9-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 16 Jan 2023, Ilpo Järvinen wrote:

> RSU_STAT_* and RSU_PROG_* checks are done in more than one place in the sec
> update code. Move the checks into new helper functions.
> 
> No function changes intended.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 59 +++++++++++++------------
>  1 file changed, 31 insertions(+), 28 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
