Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E3557954D
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Jul 2022 10:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiGSIdy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Jul 2022 04:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbiGSIdt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Jul 2022 04:33:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403A43DBC8
        for <linux-fpga@vger.kernel.org>; Tue, 19 Jul 2022 01:33:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a9so23525788lfk.11
        for <linux-fpga@vger.kernel.org>; Tue, 19 Jul 2022 01:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45mvCFcB+jXCMcylntIM3yPJvq7pOBWmdVuTz9KBhyk=;
        b=jt+IBYzr+iB6H1xwKl/uIXYPiuljC7mi3bI5v/yPyLx0Mwl5DKEBl8eX/+oln55egp
         /Wu2QLjdudc3nGe77vI4q0Zapl55UCJLaEC6Ld4XbZSrDxdZ+OukcTHkonURTjSRMbck
         eu9D07xG7P1+msvPLbofpos+Vz5JiMURxG7ICzyPdGhDbjz1gA6jzDg9TLgBdDRC5H/E
         z3Pz3PzEND8fVk4W5i0pLW9Zrb0tKVHjs7nfwGkxBu26h/vaEGJtXLtvbffpQlyGdglw
         kaTqJfmJ8zersQUQcNIzu1G10r63zuda7+68iBpckEgmV/6g8jj2s3xaXO712yEJ0rNi
         W3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45mvCFcB+jXCMcylntIM3yPJvq7pOBWmdVuTz9KBhyk=;
        b=C8/eowSfPRhCkKiKwI73onXe1Gva4zaDdHLYh89Ja6yDEHm3wUGhUj5ogDDhQ2PEsT
         j6IGajUfjDUit/unNYyFqG+duNrU6oNu65WuORs7WWnLl+KFXPHCdOYcQqkeDAxH858J
         kgSVDG7oooeRNwMkI+EQqCw6unr6RJap4SAEb746RRurXxaA7QDhOACq46zGrMkLYOxh
         UUp7gBsfmpEkOUCpYvdXyZiz0aQcFHO51K1lBCgHugh/tEIC6hPtU6Ji0b41pdiyTWPC
         QT7g5kenjPcClGsTWeNJO7GBkcVYmuvTUZvfhVzsQFvMAJqIpkyijuhRiioi1hWp3fwK
         vefw==
X-Gm-Message-State: AJIora+WJAbmX3yLefMCGunS5TJGfA4dOK/8bCbUYxT8BMB90vlyJ5r7
        SdnZZenR0vtXhbkxKrlOjiKPmA==
X-Google-Smtp-Source: AGRyM1vTrenN8StKDBqZ16IuzqbLG9wpYBFqMJBZMl6KuyD99ryY6IQbROmWQfMYlAK3gd4yvpzbdw==
X-Received: by 2002:a05:6512:1049:b0:487:8309:b378 with SMTP id c9-20020a056512104900b004878309b378mr17934712lfb.319.1658219625523;
        Tue, 19 Jul 2022 01:33:45 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id j28-20020ac2551c000000b0048329aa6c92sm3070666lfk.139.2022.07.19.01.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 01:33:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Santosh Shilimkar <ssantosh@kernel.org>, tianfei.zhang@intel.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        trix@redhat.com, russell.h.weight@intel.com,
        linux-fpga@vger.kernel.org, debaratix.biswas@intel.com,
        matthew.gerlach@linux.intel.com, yilun.xu@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memory: dfl-emif: Update the dfl emif driver support revision 1
Date:   Tue, 19 Jul 2022 10:33:41 +0200
Message-Id: <165821962017.31298.6008809074231024823.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220713130355.196115-1-tianfei.zhang@intel.com>
References: <20220713130355.196115-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, 13 Jul 2022 09:03:55 -0400, Tianfei Zhang wrote:
> From: Debarati Biswas <debaratix.biswas@intel.com>
> 
> The next generation (revision 1) of the DFL EMIF feature device requires
> support for more than 4 memory banks. It does not support the selective
> clearing of memory banks. A capability register replaces the previous
> control register, and contains a bitmask to indicate the presence of each
> memory bank. This bitmask aligns with the previous control register
> bitmask that served the same purpose. The control and capability
> registers are treated like a C Union structure in order to support both
> the new and old revisions of the EMIF device.
> 
> [...]

Applied, thanks!

[1/1] memory: dfl-emif: Update the dfl emif driver support revision 1
      https://git.kernel.org/krzk/linux-mem-ctrl/c/d16232de82d64ce02fe6d43aa51de004755de5e5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
