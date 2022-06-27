Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64A855DD3D
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Jun 2022 15:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiF0IEh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Jun 2022 04:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiF0IEe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 Jun 2022 04:04:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3DD60E9
        for <linux-fpga@vger.kernel.org>; Mon, 27 Jun 2022 01:04:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so6968391wma.4
        for <linux-fpga@vger.kernel.org>; Mon, 27 Jun 2022 01:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0FVLPiv4NDiiBhwt5cYTrJXFCY1RC0UN/Up924t8JTQ=;
        b=uaRtBKPp+icGnxfXPVREzbW2Yspl6xh4bieDYDPsmc2lcM7NQ2VdShDqFZhS+lhE81
         2v8FC6UbCn2Mcl+OR+1FAdmyK9ns8TaP1jSArfWjkRCHmt1crs+cmTyTvK8Bja2wZC+N
         x9WlNaro/CpetZtunkOCACDA0f03npEgkUONk4aXDutlWMwEhG5PNL+7A3MqP+wb+ZsV
         s8y1fT1JXdKkpBj5KY4A3KZwV7lyO0TipD0MD68koZjftVYSUnqYibXmA+z7JuOs6phv
         jSSQzbqQwRAl7KNK20nId3achcH8t4AztkzMRd1jWKYu1ru3lIUKkdHgu3K1z0nloksl
         S/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0FVLPiv4NDiiBhwt5cYTrJXFCY1RC0UN/Up924t8JTQ=;
        b=B9FzsMJjLVLApvUqB0UxEWSUdzcKKcLjjyXDstwOkJD8DRPh/FV6BNz0ZR9Vjqp6TX
         YtILrl3sZQWk+FLqzFq4ujQfrGiHXq1UOHHGk7p0/j6j9IyCXdIA5/XHLZrcGpPPlm8i
         Lk2/QDIF7thi6PxcH5G180MPOe6xRaSm5rHvQG3+i4niD/orzMXbojhsHAPSUpW/Sg9Z
         lflC/vQjXNxl7ypSlnxOr1tht2299uyG6Iu0CEoF7JVnr6bwn0151frSijshi/sza6cN
         fkP95D4KI2QAG1o6m3evOIMP8b7fRg0WIhXlLGXq8NlaF5aTbpwx43rZ9ZwZalm7Sxtl
         TrQw==
X-Gm-Message-State: AJIora9crCicvB+doZloIKqtN87LysE6jjPFJS5I7UqcUHLy65HL7rP+
        5tGCk7nN/vNwKJwzTlqwDaQ8PQ==
X-Google-Smtp-Source: AGRyM1uRpyMQGBUWRWwf72yyMy9bCFJHaoehnqnL2BK5L2HssOuVrI5PbTuruSiBPLHUjk2sd2wJTw==
X-Received: by 2002:a05:600c:2651:b0:3a0:4624:b781 with SMTP id 17-20020a05600c265100b003a04624b781mr8507964wmy.15.1656317042866;
        Mon, 27 Jun 2022 01:04:02 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id t8-20020adfdc08000000b0021350f7b22esm9613717wri.109.2022.06.27.01.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:04:02 -0700 (PDT)
Date:   Mon, 27 Jun 2022 09:04:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>, yilun.xu@intel.com,
        hao.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v3 1/3] mfd: intel-m10-bmc: rename the local variables
Message-ID: <YrlkcCdYVz8Yri+j@google.com>
References: <20220624092229.45854-1-tianfei.zhang@intel.com>
 <20220624092229.45854-2-tianfei.zhang@intel.com>
 <e6e5547e-d4d4-03a5-43cd-90922f9d1959@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6e5547e-d4d4-03a5-43cd-90922f9d1959@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, 25 Jun 2022, Tom Rix wrote:

> 
> On 6/24/22 2:22 AM, Tianfei Zhang wrote:
> > It had better use ddata for local variables which
> > directly interacts with dev_get_drvdata()/dev_set_drvdata().
> 
> This is a cleanup, not related to the patchset, it should be split from the
> patchset.

So long as they're contained in their own patch, clean-ups are fine.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
