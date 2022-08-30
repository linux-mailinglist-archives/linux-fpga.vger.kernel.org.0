Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718EC5A6C26
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 20:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiH3S1x (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 14:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiH3S1w (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 14:27:52 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830AD5B783;
        Tue, 30 Aug 2022 11:27:51 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so17916740fac.4;
        Tue, 30 Aug 2022 11:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1brh0yeX8vYrlBjmMT2cGnVzU2GJ0zMgrYrH64BW/Z4=;
        b=xASpP4yOcRWUUK2ZTSdF6Cl8EFYAPEdR+eV9HxCgI88sYt901kYjzQslYJ3/+YF66C
         nWY30Jdpwima2M/fh714YtSv98hVoMD5zl4gUZXCcfkg8/KFL/Y184bI/e3H9rVcnnJM
         7qkmozY9v3EKJVnd1LZ86mev/5HVwjeMU8XF6V7lYTI0ROWk5coZNHGNs2CNbZ0Cy2TM
         t1LFTrap1aUmCj8JlDJK71q+1GHMYE/j0QLvqB83M5ElD3sN6GqvRFugykXzTbekd0f+
         CvuPxJ87dg2GDmfdP35UEpwzDrh339lyzcVEyDJae/E/4bCwnfZHk0cYksuOrUycwsWC
         VdJA==
X-Gm-Message-State: ACgBeo1Sy/b2g/cI1btNkJj3E8L2SeHqqYxh2T+ldWduN6OtzPISeqY2
        kdaz3sN2VtkCz+EcrlYGSg==
X-Google-Smtp-Source: AA6agR5+Yqj+ik883L+JVpGoeL261r2O6KKZQNvnbuuuiPYuqkkqWfCArrLiOAOZ6S4Nr1q2ehDPwg==
X-Received: by 2002:a54:4795:0:b0:345:7d11:1cce with SMTP id o21-20020a544795000000b003457d111ccemr9585549oic.171.1661884070810;
        Tue, 30 Aug 2022 11:27:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r198-20020acaa8cf000000b00344adbc3492sm6518501oie.24.2022.08.30.11.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:27:50 -0700 (PDT)
Received: (nullmailer pid 1810442 invoked by uid 1000);
        Tue, 30 Aug 2022 18:27:49 -0000
Date:   Tue, 30 Aug 2022 13:27:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ronak.jain@xilinx.com" <ronak.jain@xilinx.com>,
        "rajan.vaja@xilinx.com" <rajan.vaja@xilinx.com>,
        "abhyuday.godhasara@xilinx.com" <abhyuday.godhasara@xilinx.com>,
        "piyush.mehta@xilinx.com" <piyush.mehta@xilinx.com>,
        "lakshmi.sai.krishna.potthuri@xilinx.com" 
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "harsha.harsha@xilinx.com" <harsha.harsha@xilinx.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH 2/4] bindings: fpga: Add binding doc for the zynqmp afi
 config driver
Message-ID: <20220830182749.GB1797396-robh@kernel.org>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-3-nava.kishore.manne@amd.com>
 <f7c9c8ee-675b-216c-0e2d-28d11890477a@linaro.org>
 <DM6PR12MB3993A3DF29033DA21DE72185CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB3993A3DF29033DA21DE72185CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Aug 30, 2022 at 05:31:07AM +0000, Manne, Nava kishore wrote:
> Hi Krzysztof,
> 
> 	Please find my response inline.
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Sent: Wednesday, August 24, 2022 6:29 PM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>; git (AMD-Xilinx)
> > <git@amd.com>; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > michal.simek@xilinx.com; mdf@kernel.org; hao.wu@intel.com;
> > yilun.xu@intel.com; trix@redhat.com; p.zabel@pengutronix.de;
> > gregkh@linuxfoundation.org; ronak.jain@xilinx.com; rajan.vaja@xilinx.com;
> > abhyuday.godhasara@xilinx.com; piyush.mehta@xilinx.com;
> > lakshmi.sai.krishna.potthuri@xilinx.com; harsha.harsha@xilinx.com;
> > linus.walleij@linaro.org; nava.manne@xilinx.com;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-fpga@vger.kernel.org
> > Subject: Re: [PATCH 2/4] bindings: fpga: Add binding doc for the zynqmp afi
> > config driver
> > 
> > On 24/08/2022 06:55, Nava kishore Manne wrote:
> > > Xilinx Zynq US+ MPSoC platform connect the PS to the programmable
> > > logic(PL) through the AXI port. This AXI port helps to establish
> > 
> > Use subject prefixes matching the subsystem (git log --oneline -- ...).
> > 
> 
> Will fix in v2.

This is what we assume. No need to reply back with agreement, and save 
us some mail to read.

Rob
