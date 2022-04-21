Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943C650A262
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 16:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388951AbiDUO2r (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 10:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388932AbiDUO2r (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 10:28:47 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AA619C0D;
        Thu, 21 Apr 2022 07:25:57 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id md4so5086297pjb.4;
        Thu, 21 Apr 2022 07:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z6eYZr81Vczs86aN15rFzTwzc9qxYGexlog897TKVyE=;
        b=IQaUg6A+aLlgCaxRhtVOL8RghI3FL66eFvPnrsOcyT9YgmFCh3Nb5zFdd5MKh54Fhw
         fw9ZAY/6ViwUnF5WxHac1kphjdmGGbUsrEK22uzWlq11OeULp1CjKj6KoCqxPTXcSmT2
         eKNm5KwrRve1kFHvRFdVIeQe0AftpOnCRA75TZ42cNXwFjjppfY8JxlmbY0Rx1uGrQQw
         LYRNGeZiChDNzTfFF2V6AQi3OJrX7cHrnId0GaAmHDtOo6iDDVpw/6me1VvO2BrB/AH8
         3MT78WR0J6hBDQ7xTWpyFV4YsWBSTmyNsTs55k5svXR+rZP09J7TbgjtCrln+Yhymyrf
         zeYg==
X-Gm-Message-State: AOAM531JlCzaGbLcWCJwoWrXdMTpmrylI1z/la8YEHYQomvZcz6vFKI2
        0Wq055wniDcS9/JH3ZVloq0=
X-Google-Smtp-Source: ABdhPJydcFcHSk+B+u3MIwIZJcsvb93QzavgusJ2o7qWb4MG6T8PeixWpLh8YgS99c3ZEYVwSsz9Ng==
X-Received: by 2002:a17:902:9a4c:b0:156:6735:b438 with SMTP id x12-20020a1709029a4c00b001566735b438mr25911941plv.46.1650551156614;
        Thu, 21 Apr 2022 07:25:56 -0700 (PDT)
Received: from localhost ([2601:647:5b00:ece1:6248:e226:d2e0:1f33])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a0022ca00b0050a858e8cc3sm14194974pfj.200.2022.04.21.07.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:25:56 -0700 (PDT)
Date:   Thu, 21 Apr 2022 07:25:54 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
Subject: Re: [PATCH v5 0/5]fpga: fix for coding style and kernel-doc issues
Message-ID: <YmFpciblvR9xnjFX@archbook>
References: <20220421044744.3777983-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421044744.3777983-1-nava.manne@xilinx.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 21, 2022 at 10:17:39AM +0530, Nava kishore Manne wrote:
> This patch series fixes the coding style and kernel-doc issues
> exists in the fpga framework, zynq and ZynqMP drivers.
> 
> Nava kishore Manne (5):
>   fpga: zynq: Fix incorrect variable type
>   fpga: fix for coding style issues
>   fpga: fpga-mgr: fix kernel-doc warnings
>   fpga: Use tab instead of space indentation
>   fpga: fpga-region: fix kernel-doc formatting issues
> 
>  drivers/fpga/Makefile            |  6 +++---
>  drivers/fpga/fpga-mgr.c          |  8 ++++++--
>  drivers/fpga/fpga-region.c       |  7 ++++---
>  drivers/fpga/of-fpga-region.c    | 22 ++++++++++++----------
>  drivers/fpga/zynq-fpga.c         |  2 +-
>  include/linux/fpga/fpga-region.h |  7 ++++---
>  6 files changed, 30 insertions(+), 22 deletions(-)
> 
> -- 
> 2.25.1
> 
I've applied patches 1-4 to for-next.

Patch 5 seems to not apply.

- Moritz
