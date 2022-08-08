Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2765358CC0F
	for <lists+linux-fpga@lfdr.de>; Mon,  8 Aug 2022 18:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiHHQWN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 8 Aug 2022 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiHHQWM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 8 Aug 2022 12:22:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22F813EB2
        for <linux-fpga@vger.kernel.org>; Mon,  8 Aug 2022 09:22:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l4so11431179wrm.13
        for <linux-fpga@vger.kernel.org>; Mon, 08 Aug 2022 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=yzkotuZd9cHwCClyBs9PM75cvWnGkFK44+8B3qT+54o=;
        b=y/dgcsVrrBvEPUi/tsXdxWb2ioO7v0EeENeioF9lXwAiObUPXaXYvqp9vZCx6E9OU1
         rCTKEWL+NfPGIzOZmgnT0iUyNi2tE8tEjG+bYfr6iH5rw5hxUigskh9Zug2Ovj5mJZzK
         ZTr2DznOXRVb3Yh9umpx0JtqbTqH+XmoDm5zyRHBScysRgbEZRPQqJULH0c09YeO2se/
         KxwmPpQgKHtW186vXtvyJ5MJLrv8uzLTk2+ehxuABUjDQu+1GNUcFh6/cVW3fg/ASS02
         btavn3blchU8WAlgHS47tZ8emKrxXIbZZyZz6MK8hDhP78rcQr3+SSII+6FWyhnWyn5h
         drEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yzkotuZd9cHwCClyBs9PM75cvWnGkFK44+8B3qT+54o=;
        b=lg77gOnf9rERZncO9zFXDLvJ5xWm3cRLQcS2Sj/eTTZ4Ll03BCvup6ba0dOypQfpAL
         1zHqu5DY7FPyPG2EH3njZKPaEtkA/B5sGvq/qVEB/x5vrXrsEOTCke/qX25cWx2qzeTo
         76srxZ4Kqk8Os5nfV4srpu7y9yNwI9SCwDrNNnFgnEjoytZtMsC4MLydbzS1jLI0dcxP
         dtTbbKehRdddwCpHBB0gMVbcEQZm2nvkHSMUF13nzUFgRiDK9bgE5dD7pEBVMAowO9Z/
         +dY4lU9F38dhY7fGej4d+Bypw9fs5r1nTXhFcptMbm4hgIuW2iInaiOSz0w956KRHzvY
         3fGg==
X-Gm-Message-State: ACgBeo3UidYGCmab3SjpGAq0+688NvnmdVwDdZDC8ahXmRDO2ByKuDNd
        hD/l4YSHkYtBzGzEwm4ZpkLACA==
X-Google-Smtp-Source: AA6agR7S2tumiMNwEMl4rfLOVm/q9POEsi+TubCWlWuvnZI0FFgR1bx/qsDAIKobtL8ooGfRipZy8w==
X-Received: by 2002:a05:6000:178b:b0:222:c6c4:b42e with SMTP id e11-20020a056000178b00b00222c6c4b42emr5164056wrg.275.1659975729342;
        Mon, 08 Aug 2022 09:22:09 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id az40-20020a05600c602800b003a310fe1d75sm19552911wmb.38.2022.08.08.09.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:22:08 -0700 (PDT)
Date:   Mon, 8 Aug 2022 17:22:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        russell.h.weight@intel.com, hao.wu@intel.com, trix@redhat.com,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3 2/2] fpga: m10bmc-sec: add m10bmc_sec_retimer_load
 callback
Message-ID: <YvE4L1aasLLd6G/X@google.com>
References: <20220808053317.3627-1-tianfei.zhang@intel.com>
 <20220808053317.3627-3-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808053317.3627-3-tianfei.zhang@intel.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 08 Aug 2022, Tianfei Zhang wrote:

> From: Russ Weight <russell.h.weight@intel.com>
> 
> Create m10bmc_sec_retimer_load() callback function
> to provide a trigger to update a new retimer (Intel
> C827 Ethernet transceiver) firmware on Intel PAC
> N3000 Card.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
> v3:
> uses regmap_update_bits() API instead of m10bmc_sys_update_bits().
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 148 ++++++++++++++++++++++++

>  include/linux/mfd/intel-m10-bmc.h       |  31 +++++

Acked-by: Lee Jones <lee@kernel.org>

-- 
DEPRECATED: Please use lee@kernel.org
