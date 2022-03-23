Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A254E51F8
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Mar 2022 13:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiCWMNu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Mar 2022 08:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiCWMNu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 23 Mar 2022 08:13:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D33EB91;
        Wed, 23 Mar 2022 05:12:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g19so1343674pfc.9;
        Wed, 23 Mar 2022 05:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Uy574NlMQLT2C/W7Xe2w7E8L3baidSP256V6jNL1nBM=;
        b=PL5u5tcRBQaWtZC2QdG5yeePgxQ9Re8f14XoWgsiy/CfuxMt+RaVgpmK8sbJLJptte
         H240NdWnIn2paiOQDFe2IXEH0X0KyJdtHKpmusBaZEKtIj03n1jI6MS9sRgCHnhs95LH
         bIgG3obY18ev+XMt1wpHaBSjUTwI++D+7SU8akTAqzUK+oeok2ZztdoHEFLpzV+62fwi
         0Z+V2o2657HLE2jJLIimnT+51FizFekGTdSJ/zZ8MozulekHRktBtAQ/xUIsHHCEWL/E
         Cf1B6uCQFofXHh6MJN5gb68zRgOMNlDX+zQkQUoZX8/sZizRnRPGhGyU6FS6LWtJTtKT
         Q+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Uy574NlMQLT2C/W7Xe2w7E8L3baidSP256V6jNL1nBM=;
        b=iFJI+k22hE130zU1i/P7HKRVfl/8ofv5/BX+o5fwMZKrAs9ub8Al4AcH2ycjaN+cvb
         Hr+RLsnuYUZjytmD1AqoBk9w+cw6dR4vTO7AOkWWIdrxKFAoaJ6/uwStKrjTnGjq15Iy
         uojoryOmp12cEriApcCXEE4qMvlXBk+HzswIizfd0pdvLXGAv9Q0BtXeOLLKTIPe5lV8
         tvQLeaamjHfLJdDU4awJmBgazGSPx40y2nDtOvSLuheDmWJsKCLpS71PJdvNaMzOjXfl
         Clj0+whzEvSTjAuExeji5Prvy/58d1y/vE8t/RpB/doYTpzPQxOnmo4fhgPgcd8At3EY
         MDog==
X-Gm-Message-State: AOAM530zhjuaValXPP/fN+j9WDFnvftyLkK86cShiRsD/HPb6V7Err0/
        VdwyoQg0R1rIzz2fGvTwN0wCAu89wr2Gx/ah
X-Google-Smtp-Source: ABdhPJxPF27V+mmlGxEdQ6Ee7gnJ1QewV6sWASf3Ggc3QVb90dIf4qGE3m1gak1G+rvDw6oIHFnIjQ==
X-Received: by 2002:a63:4707:0:b0:382:207b:889c with SMTP id u7-20020a634707000000b00382207b889cmr22153777pga.541.1648037539917;
        Wed, 23 Mar 2022 05:12:19 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-71.three.co.id. [180.214.233.71])
        by smtp.gmail.com with ESMTPSA id gt15-20020a17090af2cf00b001c755f3078dsm5710264pjb.50.2022.03.23.05.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 05:12:19 -0700 (PDT)
Message-ID: <08baab49-e6da-31ac-612f-df3f462df7a3@gmail.com>
Date:   Wed, 23 Mar 2022 19:12:13 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/2] Documentation: fpga: dfl: add description of
 Feature ID
Content-Language: en-US
To:     Tianfei Zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org
References: <20220323085102.2297964-1-tianfei.zhang@intel.com>
 <20220323085102.2297964-3-tianfei.zhang@intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220323085102.2297964-3-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 23/03/22 15.51, Tianfei Zhang wrote:
> +Individual DFL drivers are bound DFL devices based on Feature Type and Feature ID.
> +The definition of Feature Type and Feature ID can be found:
> +
> +https://github.com/OPAE/linux-dfl-feature-id/blob/master/dfl-feature-ids.rst
> +

This doesn't answer "What is Feature Type and Feature ID?" question.
I would like to see the answer and the feature list above in the kernel
documentation.

> +If you want to add a new feature ID for FPGA DFL feature device, you must submit a pull
> +request to register a feature ID for DFL. Here is the DFL Feature ID Registry:
> +
> +https://github.com/OPAE/linux-dfl-feature-id
> +

Please explain, in this document, the PR procedure regarding feature ID
registration.

-- 
An old man doll... just what I always wanted! - Clara
