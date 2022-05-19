Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3561052CDE5
	for <lists+linux-fpga@lfdr.de>; Thu, 19 May 2022 10:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiESIDk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 May 2022 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiESIDi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 May 2022 04:03:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51B15717A;
        Thu, 19 May 2022 01:03:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id bh5so4104448plb.6;
        Thu, 19 May 2022 01:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KeXnbaKJnGx6CxOBxq1EdGG+BzLXP0puOQzJvH7BluU=;
        b=AV2+qspzF8P1AKthUwMJ/5NkNWHujoMeP+vXvs6C5vYe8NDhgU2BCw+v5aNx9perC/
         ivKI7gtVbg+SgQbXC9sHTvWtlQiTOJg36B12tSNDiOgJa2PoD6I32AdOf+B0sdofxlwL
         AgtOIIHw0JySvbekQ/UKHB3zaJvYvwF0VS3WexOdvz6BtdtGY1VLFy0+BcuHzxY6c0Nn
         JCRzks5b/OPj90wfdT5w0sMdTMwUuqs9ovoH2PrDkGTvugbukqYEiOH7LVv6xYsi/5wI
         X+W4nd5kpceZWCqtyUtXSrrhgEUiSiQWtnZpTNgGvLA0hDQXuus9C9jU6USChvE82zYg
         Leig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KeXnbaKJnGx6CxOBxq1EdGG+BzLXP0puOQzJvH7BluU=;
        b=I8xZqtj2kBflYcahObqGgX21BsrBr6zIOo2XKXRsYclxw3O9KbxeFHXb2LRlFKdJ75
         ix2qtZmNNqVX494kDSQ8aCy5UD1kepn0aOtujkuXPbkKhlzfrRVa4rKvpDYTateE8dtm
         PIb94A7wn9jeWzZ7yn6sC43LvdUuu9LeqsuigXd2yF5GTcriTkXl7YWyCvERTA/F/x05
         l/aX8MWJDrGm7xySrCmdzyYMiVWHgS+pEqJmcZM3QpODpTol+o4+9ZXTc/LkDKtd7JXD
         EdaKl9K2budG8ADjc/3bmkZDNCmtueIqHR96IlSzBXVPReYiDq33aRYwUx5naIGJwPZ+
         zlrQ==
X-Gm-Message-State: AOAM5323wIKNof3gfeCq3KVHYyZ61GYJ99xSHitqstqf+eLONh0LdVcg
        6rJupFLMVvDBiXVo86MdzKU=
X-Google-Smtp-Source: ABdhPJxk3BnUOeOGCFa19Vd8sL3A2PKRDakiJVd3iG+DNRN9ods95VZOlZerRiEWkaF2gsHJ70nFXw==
X-Received: by 2002:a17:902:e94e:b0:158:91e6:501 with SMTP id b14-20020a170902e94e00b0015891e60501mr3577819pll.29.1652947405403;
        Thu, 19 May 2022 01:03:25 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902b41500b00161996b9a66sm3040382plr.233.2022.05.19.01.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 01:03:24 -0700 (PDT)
Message-ID: <3a5e3080-c1ab-a5c9-f9e7-355975fadc49@gmail.com>
Date:   Thu, 19 May 2022 15:03:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] fpga: doc: documentation for FPGA debugfs
Content-Language: en-US
To:     adrian.ho.yin.ng@intel.com, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Tull <atull@opensource.altera.com>
References: <20220517084136.3529-1-adrian.ho.yin.ng@intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220517084136.3529-1-adrian.ho.yin.ng@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 5/17/22 15:41, adrian.ho.yin.ng@intel.com wrote:
> diff --git a/Documentation/fpga/debugfs.txt b/Documentation/fpga/debugfs.txt
> new file mode 100644
> index 000000000000..1b34d5460d5d
> --- /dev/null
> +++ b/Documentation/fpga/debugfs.txt
> @@ -0,0 +1,33 @@
> +FPGA Manager DebugFS interface for FPGA reprogramming.
> +
> +Alan Tull 2016
> +

Missing (c).

> +Each FPGA gets its own directory such as <debugfs>/fpga_manager/fpga0 and
> +three files:
> +
> + - [RW] flags:          flags as defined in fpga-mgr.h.  For example:
> +
> +   $ echo 1 > /sys/kernel/debug/fpga_manager/fpga0/flags
> +
> + - [RW] firmware_name:  Name of an FPGA image firmware file.  Writing initiates
> +                        a complete FPGA programming cycle.  Note that the image
> +                        file must be in a directory on the firmware search path
> +                        such as /lib/firmware.
> +
> +   $ echo image.rbf > /sys/kernel/debug/fpga_manager/fpga0/firmware_name
> +
> + - [WO] image:          Raw FPGA image data.  Writing the FPGA image data will
> +                        initiate a complete FPGA programming cycle.  Data must
> +                        be written in one chunk, for example:
> +
> +   $ dd bs=10M if=./image.rbf of=/sys/kernel/debug/fpga_manager/fpga0/image
> +    (where image.rbf < 10M)
> +
> +To program the FPGA, write the flags (if needed), then use either the
> +firmware_name or image file to program.
> +
> +This interface does not handle bridges or loading/unloading of soft IP device
> +drivers.  This makes it really easy to mess things up by doing things like
> +reprogramming the hardware out from under a driver or reprogramming while a
> +bridge is enabled, causing gunk to go out on a cpu bus.  It should go without
> +saying that this interface is for debug only.  Not intended for production use.

Use .rst for writing docs in Documentation/ (and fix any warnings found).

-- 
An old man doll... just what I always wanted! - Clara
