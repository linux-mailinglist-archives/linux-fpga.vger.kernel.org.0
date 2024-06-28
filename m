Return-Path: <linux-fpga+bounces-563-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A7991C28A
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2024 17:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05311286707
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2024 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856521C2324;
	Fri, 28 Jun 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WncmefXZ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC30F15539F;
	Fri, 28 Jun 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588254; cv=none; b=BCIPGnzdcPbIY8732YmtPyCam3gN/z/0wgoIHl0IlSxIsMFbF5Jr7cIhdzwcc0eZQJhG+MaZW/Kg0vcGBXhYw8g+1+Npnpc61epb9OZZyXLg03MInO0l8cRvM71WRZWXuMAsrSD5XaDdf2qz2MTRR6cVZgJUa7LEqJjcrCJ4p+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588254; c=relaxed/simple;
	bh=fl9+lunxQQp9fU8I3ZADvTgh3GVml1gkscmNBnGckxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFrPHvWkMXLA5YxTnenw2vZg2HOSSD8odqevnPLPlU0bMyYFJfEltJoA04FbAm/NXKOHfR4qI/MVo3128jyXAM40wzgkBbgKmqVfJwr1ujUyqXEQE/USJdWlpQvnnyTuA7ck7Rcw7NRGSON7whhHSXel8NeoijZ1q/G82LjcQMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WncmefXZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a72459d8d6aso81027866b.0;
        Fri, 28 Jun 2024 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719588251; x=1720193051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl9+lunxQQp9fU8I3ZADvTgh3GVml1gkscmNBnGckxw=;
        b=WncmefXZRSo8uwCYj3/b8udpf6MDsTN39Mv2T7W99Z80ddaEJiULZZpdp24wXYm22q
         FcO4bXk7xSEaLMsrm4ip7dPZj3yuiFrni3IDZCKMYoaXsBNN9/UBCV8Q8WFqGMpiZcE/
         xTCTrfkD3G0B6Y8h659vKpRmYaVYMABvKC+lfWE0lhgEV1I26kM59SlPUbfgAeOLypAl
         jjRLJPGw5r2SU65eoiqWNlCWLgZXY96zAmhdzrhZsLInBA5N+XXXvUHL93+VHRKeRdFh
         nV7tAyZq+DCx/vhkboBtOXxnFte5omII2rqrjgCQ5W6v+2iNQu0ftE3rYSb6+bwelgNn
         Qx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719588251; x=1720193051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fl9+lunxQQp9fU8I3ZADvTgh3GVml1gkscmNBnGckxw=;
        b=UIIjCAb2NIVEIIj9BNBrqZm+I0mgymMzqhXvFp0ELy39je7E02BMd2aFu79dbHwIU3
         xKYL0yO8pWYCiQN3XyNNvnB2OiXRyzXeuud4qD9nzECIuXP7BGRyOx5RUSzE7iBZXNHu
         ZOfmsC7cjdC0tL4j67x0Xc8+/c9vXFCUPEiXGbK+IdqnNj/UfllBC4jLpmm9uQsehIow
         L6R2c0y5r8a8zhlBtHrjr31o6gAoyXK9h6VsOG25vknQX7Id/K8xAe7k434wL5XFwNMJ
         aESDog1OzU5cSN3Tx7P1IFz+u+fv/IijwBWFa3a6vr34AqGCSj7hZTsILBKJpMQQVyY+
         l3mw==
X-Forwarded-Encrypted: i=1; AJvYcCWHL3GL2u+Reqtc+Eue6v6WQMJcLCW3Tq56+lFXjJjHQYX+bR9pvNyaKEGeU5QHmPjjVHeBGIDJ0uxRQnLd1BHgdITbMwjVqplbkimaDwqY+ARnheYu0fQKxNY2CH3IdUe/Zv26uxfyUftXmt17iP9cJa5DxuBCArjDilP73oLNgd+5VLg=
X-Gm-Message-State: AOJu0YycFB7iVWtbkMehaJdaRgLbUkLA7TXHrPMsFGrXzJOZoSPJX0tb
	zKhl61BL+smUS9GWO7tGRtFQqtrpsWO35s+AOaJzKeFnhcGYJfS4
X-Google-Smtp-Source: AGHT+IEa9tcci5OQVDcMt3OZj5FDteTzOaDpLYyNgeBXbw6LHq9wGnw9WLex2JUqrcHt+Cn+HVxWGA==
X-Received: by 2002:a17:906:4456:b0:a6f:8a1b:9964 with SMTP id a640c23a62f3a-a7245c2ce94mr1066164066b.57.1719588251052;
        Fri, 28 Jun 2024 08:24:11 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f2e9b00e0c268ab7636554b.dip0.t-ipconnect.de. [2003:eb:5f2e:9b00:e0c2:68ab:7636:554b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72af0c9d06sm69644166b.18.2024.06.28.08.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:24:10 -0700 (PDT)
From: iansdannapel@gmail.com
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Andre Przywara <andre.przywara@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ian Dannapel <iansdannapel@gmail.com>
Subject: [PATCH v2 0/3] Summary of changes
Date: Fri, 28 Jun 2024 17:23:45 +0200
Message-Id: <20240628152348.61133-1-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620144217.124733-1-iansdannapel@gmail.com>
References: <20240620144217.124733-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1:
- Add trion/titanium specific compatibles
- done gpio renamed to cdone, as referred in the datasheet
- reset gpio renamed to creset, as referred in the datasheet
- removed fpga_mgr_states from the context struct of the low-level module
[attached: v2-0001-fpga-Add-Efinix-Trion-Titanium-serial-SPI-program.patch]

Patch 2:
- corrected examples compatible/reg/others order
- fixed 'make dt_binding_check'
[attached: v2-0002-dt-bindings-fpga-Add-Efinix-serial-SPI-programmin.patch]

Patch 3:
- renamed prefix to "efinix"
[attached: v2-0003-dt-bindings-vendor-prefix-Add-prefix-for-Efinix-I.patch]

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>

