Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA1E55D59F
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Jun 2022 15:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbiF0Ntz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Jun 2022 09:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiF0Nty (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 Jun 2022 09:49:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC8BA47E
        for <linux-fpga@vger.kernel.org>; Mon, 27 Jun 2022 06:49:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso2133873wmq.4
        for <linux-fpga@vger.kernel.org>; Mon, 27 Jun 2022 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yMnxEKpvmFxR2GNeUIkzTabL3UvC0Sa91WFWMjfUKHs=;
        b=uzMij9J2nJgMYCxwFHT0Rs5usnbl+5VnHMEgcf8WsH5/Mxg8TuOvdImD2WHu/xbppU
         YZARXM36QRCvHnxYkJ/TY4f4u/0lqzWCYVatrdhm8IjaWKWwnDFLq7ady/SMJ1H0eMD5
         IzYS7cwlYYOJY9Hb/dlQuRK4gBho8M2Vs0dFv5ipu4KdRcCiteFNLwxsb0tYixnaPD8n
         +Bl4D5Q6jtL+oLMrKDCOurA4ja2pY303dPXaw0i44efbrDc5adrwkgWX6DviLpA4lXuv
         hIlsqPcxoXZDTFoKgNy8f4b8+kd1ybybJIyphnONpwZo04rtUombakv1sT2jlbIZUK2p
         rVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yMnxEKpvmFxR2GNeUIkzTabL3UvC0Sa91WFWMjfUKHs=;
        b=i6IcnAGpQb3bJjiEsEopUeHiYSJDSWJWJPROqwECpCGuWiovXY5Hw4HhljjPQnBzsi
         y213QMHmaVQjZzhIwzpCBMpHfyOalsUvReR027zNnfk2380PiHpEQeCOPirXIbsHVIm4
         GW/Aqrz3GWtKD5+593AJBoTDYAP+0S6SGuXwb7bjLujkO1eBJSjyu5BNJC8xPHIUBVZl
         UTqdi24TbzUtePzg+Sv+DwiFv7wgOVCcWfEhkVKKiG9A3n4q7SpUq2wTvfgOOASmL9c0
         iyZDx7DKuK/KzG7fJs9dRjgytCM7aMUdZ3T+LiyPwXY864EEdgxSxLafuAjX+bEcsWwC
         CTAw==
X-Gm-Message-State: AJIora/wj/kZbb2luBLx7vyOJbuYVx1YZSaMkU/ZvYLT00hNApdq7U5z
        S0y0EBP3o5yNOwN6beDkbl1Akg==
X-Google-Smtp-Source: AGRyM1uh0glNyLsANMQNLVLq8huGqKWmR0mR/1/tQU/4tUCnILOrg3qd6LHKJq2QM+JFqMl8YzKOhg==
X-Received: by 2002:a05:600c:4e53:b0:39e:e5c4:fe9b with SMTP id e19-20020a05600c4e5300b0039ee5c4fe9bmr19610124wmq.109.1656337789473;
        Mon, 27 Jun 2022 06:49:49 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d6b8c000000b0020c5253d8fcsm12540474wrx.72.2022.06.27.06.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:49:48 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:49:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     yilun.xu@intel.com, hao.wu@intel.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v2 1/4] mfd: intel-m10-bmc: rename the local variables
Message-ID: <Yrm1e+kC/lo8PwDS@google.com>
References: <20220617020405.128352-1-tianfei.zhang@intel.com>
 <20220617020405.128352-2-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220617020405.128352-2-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 16 Jun 2022, Tianfei Zhang wrote:

> It had better use ddata for local variables which
> directly interacts with dev_get_drvdata()/dev_set_drvdata().
> 
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/mfd/intel-m10-bmc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
