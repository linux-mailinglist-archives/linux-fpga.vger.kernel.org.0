Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667BD4E46D7
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 20:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiCVTk3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 15:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiCVTk2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 15:40:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018AB6C944
        for <linux-fpga@vger.kernel.org>; Tue, 22 Mar 2022 12:39:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m26-20020a05600c3b1a00b0038c8b999f58so3969541wms.1
        for <linux-fpga@vger.kernel.org>; Tue, 22 Mar 2022 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PWSgDvDLxoqBfFqAWEkZCTO6LDckGZb0Do7Aleqt0ZM=;
        b=QJSydARTkFq8NBSIMnTKGwsIssqJp91LrDrK3seC5EBxYQpE5h6CHztkiL/0Fhxd1+
         xL5HXuLCnuUBEEg5CVRb9vytyIwa+MoCgkAwerTsb2O7BVXUE6bxN/Jx4VvYgH7Y4KFM
         ylcbeH9MhIMqDXX+A2VeguoFJs393bTTwwphraeYdm8xxXJbPNsKnptWvLTjiEfqaJpR
         cyDd4f5fvxtGFyv9HHEF2pDM0TuwlYy2I4xfRotBiwjeXpJBJjc5QpCJcIXM1HrCShqG
         NQAKBpUr/DNUfsBfYhZQ42Pe07kqiDqK6ZyO4zPsey8gwlVU4DC+4INpaTB9xzxW4zrE
         K8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PWSgDvDLxoqBfFqAWEkZCTO6LDckGZb0Do7Aleqt0ZM=;
        b=rhDhp/dw1bIFYewq60lg/eUlCjq95BzabhiAm4w+y1pOWmdDghsIXl7oKqz8/VdUGX
         9VoTQZ+ZYfYhYHdXsI/VryhxvAR/W2TG+4DqX+xIiVXq+33Ba6Bk8UrVD/CWoMtkBJk4
         0w/UJwoApO7s399bdIF/YfJinc4VsiQadCFIbVKb+lM6rawkPsKFSOWGPrER1BaDhkxK
         6cStRKwumDvEIrhEEeZhR/F773/9Se3d3IZCcKfa3XGUpb8ZdsaXLxNGiIl3Lz5RMUYC
         0ZwriGSEh5eB1i+sQbnfgvDGnfr5tkfQyZwCYn3rLQWFmyTc9glYtGH6RYVKvhwtequr
         9WPQ==
X-Gm-Message-State: AOAM532s0TVGK0kPRmmmx59BigOa4M3E13atLcIeqWrnuVPL/LJk/t9I
        nqFdr/C7DB7rHdLSpD2rUCklXQ==
X-Google-Smtp-Source: ABdhPJyFzKK4zlvzEKqOHEC37GKhdvX2QIq+k23ppppIeqB0vMfjHuNNx52y0aqkqo3+pZK6Sat+YQ==
X-Received: by 2002:a05:600c:4fc4:b0:38b:dd2e:9371 with SMTP id o4-20020a05600c4fc400b0038bdd2e9371mr5260580wmq.86.1647977938433;
        Tue, 22 Mar 2022 12:38:58 -0700 (PDT)
Received: from [192.168.2.116] ([109.76.4.19])
        by smtp.gmail.com with ESMTPSA id l12-20020a056000022c00b00203ee262d12sm12907246wrz.116.2022.03.22.12.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 12:38:57 -0700 (PDT)
Message-ID: <038b9664-2f70-7c32-6565-fbd0f3da789d@conchuod.ie>
Date:   Tue, 22 Mar 2022 19:38:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 0/2] Microchip Polarfire FPGA manager
Content-Language: en-US
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, conor.dooley@microchip.com, robh+dt@kernel.org,
        system@metrotek.ru, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
References: <20220322043219.23770-1-i.bornyakov@metrotek.ru>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220322043219.23770-1-i.bornyakov@metrotek.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 22/03/2022 04:32, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Microchip Polarfire
> FPGAs over slave SPI interface with .dat formatted bitsream image.
> 

Finally had a board appear on my desk today with its spi programming
interface exposed, so should be able to test this at last.

Thanks,
Conor.

> Changelog:
>    v1 -> v2: fix printk formating
>    v2 -> v3:
>     * replace "microsemi" with "microchip"
>     * replace prefix "microsemi_fpga_" with "mpf_"
>     * more sensible .compatible and .name strings
>     * remove unused defines STATUS_SPI_VIOLATION and STATUS_SPI_ERROR
>    v3 -> v4: fix unused variable warning
>      Put 'mpf_of_ids' definition under conditional compilation, so it
>      would not hang unused if CONFIG_OF is not enabled.
>    v4 -> v5:
>     * prefix defines with MPF_
>     * mdelay() -> usleep_range()
>     * formatting fixes
>     * add DT bindings doc
>     * rework fpga_manager_ops.write() to fpga_manager_ops.write_sg()
>       We can't parse image header in write_init() because image header
>       size is not known beforehand. Thus parsing need to be done in
>       fpga_manager_ops.write() callback, but fpga_manager_ops.write()
>       also need to be reenterable. On the other hand,
>       fpga_manager_ops.write_sg() is called once. Thus, rework usage of
>       write() callback to write_sg().
>    v5 -> v6: fix patch applying
>       I forgot to clean up unrelated local changes which lead to error on
>       patch 0001-fpga-microchip-spi-add-Microchip-MPF-FPGA-manager.patch
>       applying on vanilla kernel.
>    v6 ->v7: fix binding doc to pass dt_binding_check
> 
> Ivan Bornyakov (2):
>    fpga: microchip-spi: add Microchip MPF FPGA manager
>    dt-bindings: fpga: add binding doc for microchip-spi fpga mgr
> 
>   .../fpga/microchip,mpf-spi-fpga-mgr.yaml      |  44 ++
>   drivers/fpga/Kconfig                          |  10 +
>   drivers/fpga/Makefile                         |   1 +
>   drivers/fpga/microchip-spi.c                  | 448 ++++++++++++++++++
>   4 files changed, 503 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
>   create mode 100644 drivers/fpga/microchip-spi.c
> 
