Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683E75B18CD
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Sep 2022 11:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIHJdh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Sep 2022 05:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiIHJdC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Sep 2022 05:33:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63747113C6A;
        Thu,  8 Sep 2022 02:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8CD0B8205D;
        Thu,  8 Sep 2022 09:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84ADC433C1;
        Thu,  8 Sep 2022 09:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662629575;
        bh=jEqsB1TSbxe5EK4hQqOT2LaFLdTxGRpwjmIj9PFRUDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmEj3ACHl9ztohR5Efxco9sCu+H6eXvMxAmVBCN6yJLGkhhdQy+pcZm3WOOabB/ut
         /cKKArmCz46594IYYVaYoXgA69f1VHGD8W8GX7/70Bc44vaxH7MfJpw6f9av2AXCE7
         9Oxe5+xfISwiDlcdneXxJUU1Z+2n9BrJUBAPlqVOVO/uX4EzSwEC5YiAF9yY2eK/G3
         ViTlGlM0fTPgHXuWMisuhrK1vELaVPDu5ozA2XonnmuQH1D+AUWRLIK/0bCL4WfMSq
         7UJrAcjgpqxlSdFLu+w0pkbNsKsWLBlbW2LpTXrUEeluJka8229tVzvH09Y3StiLEt
         Iq5TQdke5CC5A==
Date:   Thu, 8 Sep 2022 10:32:49 +0100
From:   Lee Jones <lee@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        marpagan@redhat.com, matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v1 1/2] mfd: intel-m10-bmc: add d5005 bmc secure update
 driver
Message-ID: <Yxm2wbJkTBLJSqKK@google.com>
References: <20220902165706.518074-1-russell.h.weight@intel.com>
 <20220902165706.518074-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220902165706.518074-2-russell.h.weight@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 02 Sep 2022, Russ Weight wrote:

> Add the D5005 BMC secure update driver to the MAX10 BMC driver
> for D5005 devices.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/mfd/intel-m10-bmc.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
